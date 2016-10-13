//
//  TCHomeCollectionViewBaseLayout.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

struct TCHomeLayoutMargins {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
    CGFloat horizontal;
    CGFloat vertical;
};
typedef struct TCHomeLayoutMargins TCHomeLayoutMargins;

CG_INLINE TCHomeLayoutMargins
TCHomeLayoutMarginsMake(CGFloat top,
                        CGFloat left,
                        CGFloat bottom,
                        CGFloat right,
                        CGFloat horizontal,
                        CGFloat vertical)
{
    TCHomeLayoutMargins att;
    att.top = top;
    att.left = left;
    att.bottom = bottom;
    att.right = right;
    att.horizontal = horizontal;
    att.vertical = vertical;
    return att;
}

@interface TCHomeCollectionViewBaseLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) TCHomeLayoutMargins layoutMargins;
@property (nonatomic, strong) NSArray<UICollectionViewLayoutAttributes *> *attributes;
@end
