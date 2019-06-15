package 链表;

/*
 	输入: 1->2->3->4->5->NULL
	输出: 5->4->3->2->1->NULL
 * */
public class _206_反转链表 {
	
	//递归方式
	public ListNode reverseList(ListNode head) {
		//传入的为空没有意义
		//传入的head.next为空所以只有一个节点，返回head本身即可
		if (head == null || head.next == null) return head;
	
		//最终返回节点1的地址，此时head=2
		ListNode newHead = reverseList(head.next);
		// 2.next.next=2,即1.next=2这不就反转了嘛.之后2.next=3,3.next=4,4.next=5
		head.next.next = head;
		// 2.next=null/3.next=null/4.next=null/5.next=null.
		head.next = null;
		return newHead;
    }

	
	public ListNode reverseList2(ListNode head) {
		if (head == null || head.next == null) return head;
	
		ListNode newHead = null;//新头指针
		while (head != null) {
			ListNode tmp = head.next;//临时指针指向head的下一个节点
			//第一个节点指向newHead，此时为null，也就是第一个节点的指向null.也就是5->null
			//之后便是4->5-null/ 3->4->5->null / 2->3->4->5->null / 1->2->3->4->5->null
			head.next = newHead;
			//newHead指向第一个节点。测试第一个节点就被反转了。形成了newHead->5->null
			//之后便是newHead->4->5->null/newHead->3->4->5->null/newHead->2->3->4->5->null/newHead->1->2->3->4->5->null/
			newHead = head;
			//原先的头指针指向tmp，也就是指向了头结点的下一个,直到头结点的下一个是null。
			head = tmp;//最终head->null
		}
		
		return newHead;
    }

}
