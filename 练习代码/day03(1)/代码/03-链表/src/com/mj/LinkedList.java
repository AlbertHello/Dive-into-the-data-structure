package com.mj;

public class LinkedList<E> extends AbstractList<E> {
	private Node<E> first;//头指针
	
	
	private static class Node<E> {//node节点。在C语言中会写成结构体
		E element;//数据域
		Node<E> next;//指针域
		public Node(E element, Node<E> next) {
			//该节点的值
			this.element = element;
			//该节点创建后next指向谁。指向该节点的前一个节点原本指向的节点。
			//因为前一个节点重新指向了该节点，那么该节点就得指向前一个节点原本指向的节点，链表才能连接起来
			this.next = next;
		}
	}

	@Override
	public void clear() {
		size = 0;
		first = null;//first置为null后则没有指针再指向第一个元素，其他后面的节点都会被回收
	}

	@Override
	public E get(int index) {//获取某个节点的数据
		return node(index).element;
	}

	@Override
	public E set(int index, E element) {//重新给某个节点赋值
		Node<E> node = node(index);//获取index对应的节点对象
		E old = node.element;//取出旧数据
		node.element = element;//赋值新数据
		return old;
	}

	@Override
	public void add(int index, E element) {
		if (index == 0) {
//			 第一个节点
			first = new Node<>(element, first);
		} else {
			Node<E> prev = node(index - 1);//获取index前一个节点的node
			//前一个节点的next改成了此次new Node创建的地址，那新创建的node.next指向之前preNode.next
//			则新节点被加入到了链表中。
			prev.next = new Node<>(element, prev.next);
		}
//		长度加一
		size++;
	}

	@Override
	public E remove(int index) {
		Node<E> node = first;//拿到头指针
		if (index == 0) {
			//如果删除第一个节点，则直接把头指针first重新指向即可
			first = first.next;
		} else {
			Node<E> prev = node(index - 1);//获取要删除节点的前一个节点
			node = prev.next;//拿到要被删除的节点，
			//前面的节点重新指向到被删除节点的下一个节点
			//重新指向后没有指针再指向node，所以会被回收
			prev.next = node.next;
		}
		size--;//长度减一
		return node.element;
	}

	@Override
	public int indexOf(E element) {
		if (element == null) {
			Node<E> node = first;
			for (int i = 0; i < size; i++) {
				if (node.element == null) return i;
				
				node = node.next;
			}
		} else {
			Node<E> node = first;
			for (int i = 0; i < size; i++) {
				if (element.equals(node.element)) return i;
				
				node = node.next;
			}
		}
		return ELEMENT_NOT_FOUND;
	}
	
	/**
	 * 获取index位置对应的节点对象
	 * @param index
	 * @return
	 */
	private Node<E> node(int index) {
		rangeCheck(index);
		
		Node<E> node = first;
		for (int i = 0; i < index; i++) {
			node = node.next;
		}
		return node;
	}
	
	@Override
	public String toString() {
		StringBuilder string = new StringBuilder();
		string.append("size=").append(size).append(", [");
		Node<E> node = first;
		for (int i = 0; i < size; i++) {
			if (i != 0) {
				string.append(", ");
			}
			
			string.append(node.element);
			
			node = node.next;
		}
		string.append("]");
		
//		Node<E> node1 = first;
//		while (node1 != null) {
//			
//			
//			node1 = node1.next;
//		}
		return string.toString();
	}
}
