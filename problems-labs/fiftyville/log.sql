-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT description FROM crime_scene_reports WHERE month = 7 AND day = 28 AND year = 2021;
--+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
--|                                                                                                       description                                                                                                        |
--+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
--| Vandalism took place at 12:04. No known witnesses.                                                                                                                                                                       |
--| Shoplifting took place at 03:01. Two people witnessed the event.                                                                                                                                                         |
--| Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |
--| Money laundering took place at 20:30. No known witnesses.                                                                                                                                                                |
--| Littering took place at 16:36. No known witnesses.                                                                                                                                                                       |
--+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

--Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
--Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.

SELECT transcript FROM interviews WHERE month = 7 AND day = 28 AND year = 2021;
--+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
--|                                                                                                                                                     transcript                                                                                                                                                      |
--+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
--| “Ah,” said he, “I forgot that I had not seen you for some weeks. It is a little souvenir from the King of Bohemia in return for my assistance in the case of the Irene Adler papers.”                                                                                                                               |
--| “I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having gone to the ball.”                                                                                                                                                                                      |
--| “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.” He looked from one to the other of us, as if uncertain which to address.                                                                                                                   |
--| Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
--| I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
--| As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
--| Our neighboring courthouse has a very annoying rooster that crows loudly at 6am every day. My sons Robert and Patrick took the rooster to a city far, far away, so it may never bother us again. My sons have successfully arrived in Paris.                                                                        |
--| I'm the bakery owner, and someone came in, suspiciously whispering into a phone for about half an hour. They never bought anything.                                                                                                                                                                                 |
--+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

SELECT license_plate FROM bakery_security_logs WHERE activity = "exit" AND month = 7 AND day = 28 AND year = 2021 AND hour = 10 AND minute > 15 AND minute < 25;
--+---------------+
--| license_plate |
--+---------------+
--| 5P2BI95       |
--| 94KL13X       |
--| 6P58WS2       |
--| 4328GD8       |
--| G412CB7       |
--| L93JTIZ       |
--| 322W7JE       |
--| 0NTHK55       |
--+---------------+

SELECT name FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE activity = "exit" AND month = 7 AND day = 28 AND year = 2021 AND hour = 10 AND minute > 15 AND minute < 25;

--+---------+
--|  name   |
--+---------+
--| Vanessa |
--| Barry   |
--| Iman    |
--| Sofia   |
--| Luca    |
--| Diana   |
--| Kelsey  |
--| Bruce   |
--+---------+

SELECT account_number FROM atm_transactions WHERE atm_location = "Leggett Street" AND month = 7 AND day = 28 AND year = 2021 AND transaction_type = "withdraw";
--+----------------+
--| account_number |
--+----------------+
--| 28500762       |
--| 28296815       |
--| 76054385       |
--| 49610011       |
--| 16153065       |
--| 25506511       |
--| 81061156       |
--| 26013199       |
--+----------------+

SELECT name FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE atm_location = "Leggett Street" AND month = 7 AND day = 28 AND year = 2021 AND transaction_type = "withdraw"));
--+---------+
--|  name   |
--+---------+
--| Kenny   |
--| Iman    |
--| Benista |
--| Taylor  |
--| Brooke  |
--| Luca    |
--| Diana   |
--| Bruce   |
--+---------+

--+---------+
--|  name   |
--+---------+
--| |
--|    |
--| Iman    |
--|         |
--| Luca    |
--| Diana   |
--|         | PEOPLE WHO EXITED BAKERY DURING TIME OF THEFT AND MADE A WITHDRAWAL ON LEGGETT STREET ON DAY OF THEFT
--| Bruce   |
--+---------+

--WHO TOOK A FLIGHT THAT DAY OR WHO MADE A PHONE CALL?

SELECT caller, receiver FROM phone_calls WHERE month = 7 AND day = 28 AND year = 2021 AND duration < 60;
--+----------------+----------------+
--|     caller     |    receiver    |
--+----------------+----------------+
--| (130) 555-0289 | (996) 555-8899 |
--| (499) 555-9472 | (892) 555-8872 |
--| (367) 555-5533 | (375) 555-8161 |
--| (499) 555-9472 | (717) 555-1342 |
--| (286) 555-6063 | (676) 555-6554 |
--| (770) 555-1861 | (725) 555-3243 |
--| (031) 555-6622 | (910) 555-3251 |
--| (826) 555-1652 | (066) 555-9701 |
--| (338) 555-6650 | (704) 555-2131 |
--+----------------+----------------+

--WHAT ARE IMAN LUCA DIANA and BRUCE's PHONE NUMBER?

SELECT phone_number FROM people WHERE name = "Iman";
--+----------------+
--|  phone_number  |
--+----------------+
--| (829) 555-5269 |
--+----------------+
SELECT phone_number FROM people WHERE name = "Luca";
--+----------------+
--|  phone_number  |
--+----------------+
--| (389) 555-5198 |
--+----------------+
SELECT phone_number FROM people WHERE name = "Diana";
--+----------------+
--|  phone_number  |
--+----------------+
--| (770) 555-1861 |
--+----------------+  she called (725) 555-3243 (Phillip)
SELECT phone_number FROM people WHERE name = "Bruce";
--+----------------+
--|  phone_number  |
--+----------------+
--| (367) 555-5533 |
--+----------------+  he called (375) 555-8161 (Robin)

--DIANA AND BRUCE MADE PHONE CALLS ON THE DAY OF THE THEFT THAT LASTED UNDER A MINUTE, DID EITHER OF THEM BOOK A FLIGHT?

--+---------+
--|  name   |
--+---------+
--| Vanessa |
--| Barry   |
--| Iman    |
--| Sofia   |
--| Luca    |
--| Diana   |
--| Kelsey  |
--| Bruce   | PEOPLE WHO EXITED BAKERY DURING TIME OF THEFT
--+---------+ NEED THESE PHONE NUMBERS TO SEE IF THEY CALLED ON DAY OF THEFT DURATION < 1 MINUTE
SELECT phone_number FROM people WHERE name = "Vanessa";
--+----------------+
--|  phone_number  |
--+----------------+
--| (725) 555-4692 |
--+----------------+
SELECT phone_number FROM people WHERE name = "Barry";
--+----------------+
--|  phone_number  |
--+----------------+
--| (301) 555-4174 |
--+----------------+
SELECT phone_number FROM people WHERE name = "Iman";
--+----------------+
--|  phone_number  |
--+----------------+
--| (829) 555-5269 |
--+----------------+
SELECT phone_number FROM people WHERE name = "Sofia";
--+----------------+
--|  phone_number  |
--+----------------+
--| (130) 555-0289 |
--+----------------+
SELECT phone_number FROM people WHERE name = "Luca";
--+----------------+
--|  phone_number  |
--+----------------+
--| (389) 555-5198 |
--+----------------+
SELECT phone_number FROM people WHERE name = "Diana";
--+----------------+
--|  phone_number  |
--+----------------+
--| (770) 555-1861 |
--+----------------+
SELECT phone_number FROM people WHERE name = "Kelsey";
--+----------------+
--|  phone_number  |
--+----------------+
--| (499) 555-9472 |
--+----------------+
SELECT phone_number FROM people WHERE name = "Bruce";
--+----------------+
--|  phone_number  |
--+----------------+
--| (367) 555-5533 |
--+----------------+
SELECT caller, receiver FROM phone_calls WHERE month = 7 AND day = 28 AND year = 2021 AND duration < 60;
--+----------------+----------------+
--|     caller     |    receiver    |
--+----------------+----------------+
--| (130) 555-0289 | (996) 555-8899 |
--| (499) 555-9472 | (892) 555-8872 |
--| (367) 555-5533 | (375) 555-8161 |
--| (499) 555-9472 | (717) 555-1342 |
--| (286) 555-6063 | (676) 555-6554 |
--| (770) 555-1861 | (725) 555-3243 |
--| (031) 555-6622 | (910) 555-3251 |
--| (826) 555-1652 | (066) 555-9701 |
--| (338) 555-6650 | (704) 555-2131 |
--+----------------+----------------+
--COULD BE SOFIA DIANA KELSEY BRUCE

--WHOEVER THEY CALLED WOULD'VE BEEN THE PERSON TO MAKE A TRANSACTION ON LEGGETT STREET ON THAT DAY

--(996) 555-8899
--(725) 555-3243
--(717) 555-1342
--(375) 555-8161
--POTENTIAL ACCOMPLICES
SELECT name FROM people WHERE id IN (SELECT person_id FROM bank_accounts WHERE account_number IN (SELECT account_number FROM atm_transactions WHERE atm_location = "Leggett Street" AND transaction_type = "withdraw" AND month = 7 AND day = 28 AND year = 2021)) AND phone_number IN (SELECT caller FROM phone_calls WHERE duration < 60 AND month = 7 AND day = 28 AND year = 2021);
--+---------+
--|  name   |
--+---------+
--| Kenny   |
--| Benista |
--| Taylor  |
--| Diana   |
--| Bruce   |
--+---------+  CHECK IF THEY HAD A FLIGHT THE NEXT DAY

SELECT name FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE activity = "exit" AND minute > 15 AND minute < 25 AND month = 7 AND day = 28 AND year = 2021)
AND id IN (SELECT person_id FROM bank_accounts WHERE account_number
IN (SELECT account_number FROM atm_transactions WHERE transaction_type = "withdraw" AND atm_location = "Leggett Street" AND month = 7 AND day = 28 AND year = 2021))
AND phone_number IN (SELECT caller FROM phone_calls WHERE duration < 60 AND month = 7 AND day = 28 AND year = 2021)
AND passport_number IN (SELECT passport_number FROM flights WHERE origin_airport_id = 8 AND hour = 8 AND minute = 20 AND month = 7 AND day = 29 AND year = 2021);
--+-------+
--| name  |
--+-------+
--| Diana |
--| Bruce |
--+-------+
SELECT city FROM airports WHERE id = (SELECT destination_airport_id FROM flights WHERE hour = 8 AND minute = 20 AND month = 7 AND day = 29 AND year = 2021);
--+---------------+
--|     city      |
--+---------------+
--| New York City |
--+---------------+
--EITHER DIANA OR BRUCE IS THE THIEF, THEIR ACCOMLPICE WOULD'VE BEEN THE PERSON THEY CALLED
--PHILIP OR ROBIN IS THE ACCOMPLICE

 SELECT seat FROM passengers WHERE passport_number IN (SELECT passport_number FROM people WHERE name = "Bruce") AND flight_id IN (SELECT id FROM flights WHERE origin_airport_id = 8 AND hour = 8 AND minute = 20 AND month = 7 AND day = 29 AND year = 2021);
--+------+
--| seat |
--+------+
--| 4A   |
--+------+
--SAME QUERY WITH DIANA YEILDED NO RESULT! BRUCE IS THE THIEF AND HIS ACCOMPLICE IS ROBIN