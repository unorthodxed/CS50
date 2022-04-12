

// Complete the mergeLists function below.
//Problem: https://www.hackerrank.com/challenges/one-week-preparation-kit-merge-two-sorted-linked-lists/problem
/*
 * For your reference:
 *
 * SinglyLinkedListNode {
 *     int data;
 *     SinglyLinkedListNode* next;
 * };
 *
 */
SinglyLinkedListNode* mergeLists(SinglyLinkedListNode* head1, SinglyLinkedListNode* head2) 
{
    SinglyLinkedListNode* l1 = head1;
    SinglyLinkedListNode* l2 = head2;
    SinglyLinkedListNode* dummyNode = new SinglyLinkedListNode(-1);
    SinglyLinkedListNode* temp = dummyNode;
    while (l1 != NULL && l2 != NULL) 
    {
        if (l1->data < l2->data)
        {
            temp->next = l1;
            l1 = l1->next;
        }
        else 
        {
            temp->next = l2;
            l2 = l2->next;
        }
        temp = temp->next;
    }
    while (l1 != NULL)
    {
    temp->next = l1;
    l1 = l1->next;
    temp = temp->next;
    }
    while (l2 != NULL) 
    {
    temp->next = l2;
    l2 = l2->next;
    temp = temp->next;
    }
     return dummyNode->next;
}

