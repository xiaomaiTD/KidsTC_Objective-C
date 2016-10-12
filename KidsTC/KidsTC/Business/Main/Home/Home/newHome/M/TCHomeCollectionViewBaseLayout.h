//
//  TCHomeCollectionViewBaseLayout.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

struct TCHomeLayoutAttributes {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
    CGFloat horizontal;
    CGFloat vertical;
};
typedef struct TCHomeLayoutAttributes TCHomeLayoutAttributes;

CG_INLINE TCHomeLayoutAttributes
TCHomeLayoutAttributesMake(CGFloat top,
                           CGFloat left,
                           CGFloat bottom,
                           CGFloat right,
                           CGFloat horizontal,
                           CGFloat vertical)
{
    TCHomeLayoutAttributes att;
    att.top = top;
    att.left = left;
    att.bottom = bottom;
    att.right = right;
    att.horizontal = horizontal;
    att.vertical = vertical;
    return att;
}

@interface TCHomeCollectionViewBaseLayout : UICollectionViewLayout
@property (nonatomic, assign) TCHomeLayoutAttributes layoutAttributes;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) CGFloat columnCount;
+ (instancetype)layoutWithCount:(int)count
                    columnCount:(int)columnCount
               layoutAttributes:(TCHomeLayoutAttributes)layoutAttributes;
@end
