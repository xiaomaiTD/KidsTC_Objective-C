//
//  TCHomeCollectionViewThreeLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeCollectionViewThreeLayout.h"

@implementation TCHomeCollectionViewThreeLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];
    }
    return array;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat w = CGRectGetWidth(self.collectionView.bounds);
    CGFloat h = CGRectGetHeight(self.collectionView.bounds);
    if (indexPath.row==0) {
        att.frame = CGRectMake(0, 0, w/2, h);
    }else if (indexPath.row == 1) {
        att.frame = CGRectMake(w/2, 0, w/2, h/2);
    }else{
        att.frame = CGRectMake(w/2, h/2, w/2, h/2);
    }
    return att;
}
@end
