//
//  TCHomeCollectionViewOneToFourLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeCollectionViewOneToFourLayout.h"
CGFloat const TCHomeCollectionViewOneToFourLayoutMargin = 12;

@implementation TCHomeCollectionViewOneToFourLayout
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
    
    CGFloat collectionView_w = CGRectGetWidth(self.collectionView.bounds);
    CGFloat collectionView_h = CGRectGetHeight(self.collectionView.bounds);
    CGFloat margin = TCHomeCollectionViewOneToFourLayoutMargin;
    CGFloat att_y = margin;
    CGFloat att_w = (collectionView_w - (_count - 1) * margin)/_count;
    CGFloat att_h = collectionView_h - margin * 2;
    CGFloat att_x = margin + (att_w + margin) * indexPath.row;
    att.frame = CGRectMake(att_x, att_y, att_w, att_h);
    
    return att;
}
@end
