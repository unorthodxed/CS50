import os
# Problem: https://cs50.harvard.edu/x/2022/psets/9/finance/
from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required, lookup, usd

from datetime import datetime
# datetime object containing current date and time
now = datetime.now()

# dd/mm/YY H:M:S
dt_string = now.strftime("%d/%m/%Y %H:%M:%S")

# Configure application
app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

# Make sure API key is set
if not os.environ.get("API_KEY"):
    raise RuntimeError("API_KEY not set")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""
    #current_price = lookup(stock)
    current_shares = db.execute("SELECT stock, shares FROM current WHERE id = ?", session["user_id"])
    current_price = []
    n = len(current_shares)
    total_cash = 0
    for i in current_shares:
        current_price.append(lookup(i["stock"]))
    for j in range(len(current_shares)):
        total_cash += current_price[j]["price"] * float(current_shares[j]["shares"])
    balance = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])
    total_cash += balance[0]["cash"]
    print(current_shares)
    print(current_price)
    return render_template("index.html", current_shares=current_shares, current_price=current_price, n=n, total_cash=total_cash, balance=balance, usd=usd)


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method == "POST":
        if not request.form.get("symbol") or not lookup(request.form.get("symbol")):
            return apology("Please enter a valid stock symbol and ensure both fields are filled.")
        if not request.form.get("shares"):
            return apology("Please enter a valid number of shares.")
        symbol = lookup(request.form.get("symbol"))
        price = symbol["price"]
        shares_bought = request.form.get("shares")
        ch = '/'
        if shares_bought.find(ch) != -1:
            return apology("Please enter an integer or decimal number.")
        elif shares_bought.isdigit() == False or float(shares_bought) < 0:
            return apology("Please enter a valid number of shares.")
        shares_bought = float(shares_bought)
        cost = shares_bought * price
        balance = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])
        cash = balance[0]["cash"]
        if cash > cost:
            print(symbol)
            print(price)
            db.execute("INSERT INTO purchases(id, stock, price, shares, date_time) VALUES(?, ?, ?, ?, ?)", session["user_id"], symbol["symbol"], price, shares_bought, dt_string)
            new_balance = cash - cost
            current_shares = db.execute("SELECT shares FROM current WHERE id = ? AND stock = ?", session["user_id"], symbol["symbol"])
            try:
                new_shares = current_shares[0]["shares"] + shares_bought
                db.execute("UPDATE current SET shares = ? WHERE stock = ?", new_shares, symbol["symbol"])
            except:
                new_shares = shares_bought
                db.execute("INSERT INTO current(id, stock, shares) VALUES(?, ?, ?)", session["user_id"], symbol["symbol"], new_shares)
            db.execute("UPDATE users SET cash = ? WHERE id = ?", new_balance, session["user_id"])
            current_shares = db.execute("SELECT stock, shares FROM current WHERE id = ?", session["user_id"])
            current_price = []
            n = len(current_shares)
            total_cash = 0
            for i in current_shares:
                current_price.append(lookup(i["stock"]))
            for j in range(len(current_shares)):
                total_cash += current_price[j]["price"] * float(current_shares[j]["shares"])
            balance = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])
            total_cash += balance[0]["cash"]
            return render_template("index.html", n=n, current_shares=current_shares, current_price=current_price, total_cash=total_cash, balance=balance, usd=usd)
        else:
            return apology("Insufficient funds.")
    else:
        return render_template("buy.html")

@app.route("/history")
@login_required
def history():
    """Show history of transactions"""
    buys = db.execute("SELECT * FROM purchases WHERE id = ?", session["user_id"])
    sells = db.execute("SELECT * FROM sales WHERE id = ?", session["user_id"])
    return render_template("history.html", buys=buys, sells=sells, usd=usd)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")

@app.route("/changepassword", methods=["GET", "POST"])
def changepassword():
    """Change Password"""
    if request.method == "GET":
        return render_template("changepassword.html")
    else:
        if not request.form.get("newpass") or not request.form.get("confirmpass"):
            return apology("Please enter both fields.")
        if request.form.get("newpass") != request.form.get("confirmpass"):
            return apology("Please make sure both passwords match.")
        newpass = request.form.get("newpass")
        db.execute("UPDATE users SET hash = ? WHERE id = ?", generate_password_hash(newpass), session["user_id"])
        return render_template("changepassword.html")

@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    if request.method == "GET":
        return render_template("quote.html")
    else:
        if not lookup(request.form.get("symbol")):
            return apology("Please enter a valid stock symbol")
        symbol = lookup(request.form.get("symbol"))
        return render_template("quoted.html", symbol=symbol, usd=usd)


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""
    if request.method == "POST":
        if not request.form.get("username"):
            return apology("Registration Error: Username field cannot be left blank")
        elif request.form.get("username") in db.execute("SELECT * FROM users"):
            return apology("Registration Error: Username has already been taken.")
        else:
            username = request.form.get("username")
            checker = db.execute("SELECT username FROM users WHERE EXISTS (SELECT id FROM users WHERE username = ?)", username)
            if checker:
                return apology("Username already taken.")
        if not request.form.get("password") or not request.form.get("confirmation"):
            return apology("Registration Error: Password required for signup")
        elif request.form.get("password") != request.form.get("confirmation"):
            return apology("Registration Error: Passwords do not match.")
        else:
            password = request.form.get("password")
            confirmation = request.form.get("confirmation")
        db.execute("INSERT INTO users(username, hash) VALUES(?, ?)", username, generate_password_hash(password))
        return render_template("login.html")
    else:
        return render_template("register.html")

@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""
    if request.method == "GET":
        current_shares = db.execute("SELECT stock FROM current WHERE id = ?", session["user_id"])
        return render_template("sell.html", current_shares=current_shares)
    else:
        if not request.form.get("symbol") or not request.form.get("shares"):
            return apology("Please select a stock and valid number of shares.")
        symbol = request.form.get("symbol")
        price = lookup(symbol)["price"]
        shares_sold = request.form.get("shares")
        print(symbol)
        print(price)
        print(shares_sold)
        current_shares = db.execute("SELECT shares FROM current WHERE stock = ? AND id = ?", symbol, session["user_id"])
        print(current_shares)
        new_shares = float(current_shares[0]["shares"]) - float(shares_sold)
        if new_shares < 0:
            return apology("Insufficient funds")
        balance = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])
        cash = balance[0]["cash"]
        new_balance = cash + (price * float(shares_sold))
        print(new_balance)
        print(new_shares)
        db.execute("UPDATE current SET shares = ? WHERE id = ? AND stock = ?", new_shares, session["user_id"], symbol)
        current_shares = db.execute("SELECT shares FROM current WHERE stock = ? AND id = ?", symbol, session["user_id"])
        db.execute("INSERT INTO sales(id, stock, price, shares, date_time) VALUES(?, ?, ?, ?, ?)", session["user_id"], symbol, price, float(shares_sold), dt_string)
        db.execute("UPDATE users SET cash = ? WHERE id = ?", new_balance, session["user_id"])
        current_shares = db.execute("SELECT stock, shares FROM current WHERE id = ?", session["user_id"])
        current_price = []
        n = len(current_shares)
        total_cash = 0
        for i in current_shares:
            current_price.append(lookup(i["stock"]))
        for j in range(len(current_shares)):
            total_cash += current_price[j]["price"] * float(current_shares[j]["shares"])
        balance = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])
        total_cash += balance[0]["cash"]
        return render_template("index.html", n=n, current_shares=current_shares, current_price=current_price, total_cash=total_cash, balance=balance, usd=usd)
