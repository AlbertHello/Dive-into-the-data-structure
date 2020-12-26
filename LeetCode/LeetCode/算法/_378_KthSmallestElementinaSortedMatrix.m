//
//  _378_KthSmallestElementinaSortedMatrix.m
//  LeetCode
//
//  Created by Albert on 2020/12/20.
//

#import "_378_KthSmallestElementinaSortedMatrix.h"
#import "QuickSort.h"
@implementation _378_KthSmallestElementinaSortedMatrix


/**
 378. 有序矩阵中第K小的元素
 难度 中等
 https://leetcode-cn.com/problems/kth-smallest-element-in-a-sorted-matrix/
 给定一个 n x n 矩阵，其中每行和每列元素均按升序排序，找到矩阵中第 k 小的元素。
 请注意，它是排序后的第 k 小元素，而不是第 k 个不同的元素。
 示例：
 matrix = [
    [ 1,  5,  9],
    [10, 11, 13],
    [12, 13, 15]
 ],
 k = 8,
 返回 13。
 提示：
 你可以假设 k 的值永远是有效的，1 ≤ k ≤ n^2 。
 */


/**
 解法1
 最直接的做法是将这个二维数组另存为为一维数组，并对该一维数组进行排序。最后这个一维数组中的第
 k 个数即为答案。
 时间复杂度：O(n^2  logn)，对 n^2个数排序。
 空间复杂度：O(n^2)一维数组需要存储n^2个数。
 */
int kthSmallest(int **matrix, int matrixSize, int *matrixColSize, int k) {
    int *rec = (int *)malloc(matrixSize * matrixSize * sizeof(int));
    int num = 0;
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixColSize[i]; j++) {
            rec[num++] = matrix[i][j];
        }
    }
    quick_sort(rec, 0, num);
    return rec[k - 1];
}

/**
 解法2
 */
typedef struct point {
    int val, x, y;
} point;

bool cmp_378(point a, point b) {
    return a.val >= b.val;
}
void swap_378(point* a, point* b) {
    point t = *a;
    *a = *b;
    *b = t;
}
void push(point heap[], int* size, point* p) {
    heap[++(*size)] = *p;
    int s = (*size);
    while (s > 1) {
        // heap[s] 是否大于 heap[s >> 1]
        // 把大的
        if (cmp_378(heap[s], heap[s >> 1])) {
            break;
        }
        swap_378(&heap[s], &heap[s >> 1]);
        s >>= 1;
    }
}
void pop(point heap[], int* size) {
    heap[1] = heap[(*size)--];
    int p = 1, s = 2;
    while (s <= (*size)) {
        if (s < (*size) && !cmp_378(heap[s + 1], heap[s])) {
            s++;
        }
        if (cmp_378(heap[s], heap[p])) {
            break;
        }
        swap_378(&heap[s], &heap[p]);
        p = s;
        s = p << 1;
    }
}
int kthSmallest2(int** matrix, int matrixSize, int* matrixColSize, int k) {
    point heap[matrixSize + 1];
    int size = 0;
    for (int i = 0; i < matrixSize; i++) {
        // matrix[i][0]是具体的值，后面的(i,0)是在记录候选人在矩阵中的位置，
        // 方便每次右移添加下一个候选人
        point p = {matrix[i][0], i, 0}; // 取出第一列候选人
        push(heap, &size, &p); // 构建最小堆
    }
    for (int i = 0; i < k - 1; i++) { // 一共弹k次：这里k-1次，return的时候1次
        point now = heap[1];
        pop(heap, &size); // #弹出候选人里最小一个
        if (now.y != matrixSize - 1) { // 如果这一行还没被弹完
            // 加入这一行的下一个候选人
            point p = {matrix[now.x][now.y + 1], now.x, now.y + 1};
            push(heap, &size, &p);
        }
    }
    return heap[1].val;
}

@end
