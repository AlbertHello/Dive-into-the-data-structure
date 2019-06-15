package 链表;

/**
 * https://leetcode-cn.com/problems/delete-node-in-a-linked-list/
 * @author MJ Lee
 *
 */
public class _237_删除链表中的节点 {
	
	public void deleteNode(ListNode node) {
		//删除节点，因为拿不到该节点前面的节点，只能拿到后面的节点。
		//所以用后面节点的值替换该节点的值。
		node.val = node.next.val;
		//再把该节点的next指向后节点本来所指向的节点即可。
		node.next = node.next.next;
    }
}
