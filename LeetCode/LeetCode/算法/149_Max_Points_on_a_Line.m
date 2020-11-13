//
//  149_Max_Points_on_a_Line.m
//  LeetCode
//
//  Created by 58 on 2020/10/26.
//

#import "149_Max_Points_on_a_Line.h"

@implementation _49_Max_Points_on_a_Line

/**
 149. 直线上最多的点数
 
 给定一个二维平面，平面上有 n 个点，求最多有多少个点在同一条直线上。

 示例 1:

 输入: [[1,1],[2,2],[3,3]]
 输出: 3
 解释:
 ^
 |
 |        o
 |     o
 |  o
 +------------->
 0  1  2  3  4
 
 示例 2:

 输入: [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]
 输出: 4
 解释:
 ^
 |
 |  o
 |     o        o
 |        o
 |  o        o
 +------------------->
 0  1  2  3  4  5  6

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/max-points-on-a-line
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

int maxPoints(int** points, int pointsSize, int* pointsColSize){

    return 0;
}

/**
 「点斜式」，换句话，一个点加一个斜率即可唯一的确定一条直线。

 所以我们可以对「点」进行分类然后去求，问题转换成，经过某个点的直线，哪条直线上的点最多。
 当确定一个点后，平面上的其他点都和这个点可以求出一个斜率，斜率相同的点就意味着在同一条直线上。

 所以我们可以用 HashMap 去计数，斜率作为 key，然后遍历平面上的其他点，相同的 key 意味着在同一条直线上。

 上边的思想解决了「经过某个点的直线，哪条直线上的点最多」的问题。接下来只需要换一个点，然后用同样的方法考虑完所有的点即可。

 当然还有一个问题就是斜率是小数，怎么办。

 之前提到过了，我们用分数去表示，求分子分母的最大公约数，然后约分，最后将 「分子 + "@" + "分母"」作为 key 即可。

 最后还有一个细节就是，当确定某个点的时候，平面内如果有和这个重叠的点，如果按照正常的算法约分的话，会出现除 0 的情况，所以我们需要单独用一个变量记录重复点的个数，而重复点一定是过当前点的直线的
 */
-(NSUInteger)maxPoints:(NSArray *)array colsize:(NSUInteger *)pointsColSize{
    
    if (array.count<3){
        *pointsColSize=2;
        return array.count;
    }
    NSUInteger res=0;
    for (int i=0; i<array.count; i++) {
        NSUInteger duplicate=0,max=0;
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        for (int j = i + 1; j < array.count; j++) {
            //求出分子分母
            NSArray *sonArr_i=array[i];
            NSArray *sonArr_j=array[j];
            int x = [sonArr_j[0] intValue] - [sonArr_i[0] intValue];
            int y = [sonArr_j[1] intValue] - [sonArr_i[1] intValue];
            //重复
            if (x == 0 && y == 0) {
                duplicate++;
                continue;
            }
            //进行约分
            int gcd = yuefen(x, y);
            //拿到最大公倍数后分子分母再除以这个公倍数就是最简分式了
            x = x / gcd;
            y = y / gcd;
            
            NSString *key = [NSString stringWithFormat:@"%d@%d",x,y];
            int temp=[dict[key] intValue]+1;
            dict[key]=@(temp);
            max=(max > temp)?max:temp;
        }
        //1 代表当前考虑的点，duplicate 代表和当前的点重复的点
        res=(res>(max+duplicate+1))?res:(max+duplicate+1);
    }
    return res;
}

//约分得到的值是分子分母的最大公倍数
//然后拿到值后分子分母再除以这个公倍数就是最简分式了
int yuefen(int a, int b) {
    while (b != 0) {
        int temp = a % b;
        a = b;
        b = temp;
    }
    return a;
}

+(void)maxPointsTests{
    NSArray *aaa=@[
                @[@(1),@(1)],
                @[@(3),@(2)],
                @[@(5),@(3)],
                @[@(4),@(1)],
                @[@(2),@(3)],
                @[@(1),@(4)],
    ];
    _49_Max_Points_on_a_Line *max=[[_49_Max_Points_on_a_Line alloc]init];
    NSLog(@"%lu",(unsigned long)[max maxPoints:aaa colsize:nil]);
}


@end




