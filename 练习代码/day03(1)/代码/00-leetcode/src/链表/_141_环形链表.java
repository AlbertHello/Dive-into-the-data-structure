package 链表;

public class _141_环形链表 {
	
	// 快慢指针方法 快指针一部走两个节点，慢指针一步走一个节点
	public boolean hasCycle(ListNode head) {
		if (head == null || head.next == null) return false;
		
		ListNode slow = head;
		ListNode fast = head.next;
		while (fast != null && fast.next != null) {
			slow = slow.next;
			fast = fast.next.next;
			//如果有环 快慢指针一定会有相等的时候
			if (slow == fast) return true;
		}
		
		return false;
    }
	
}
