//
//  TCHomeCollectionViewHorizontalListLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeCollectionViewHorizontalListLayout.h"

@implementation TCHomeCollectionViewHorizontalListLayout

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
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionView_w = CGRectGetWidth(self.collectionView.bounds);
    CGFloat collectionView_h = CGRectGetHeight(self.collectionView.bounds);
    NSUInteger row = indexPath.row;
    TCHomeLayoutAttributes att = self.layoutAttributes;
    CGFloat columnCount = self.columnCount;
    int marginCountH = (columnCount - (int)columnCount) > 0 ? (int)columnCount : (columnCount - 1);
    CGFloat att_w = (collectionView_w - att.left - att.right - att.horizontal * marginCountH) / columnCount;
    CGFloat att_h = (collectionView_h - att.top - att.bottom);
    CGFloat att_x = att.left + (att_w + att.horizontal) * row;
    CGFloat att_y = att.top;
    attributes.frame = CGRectMake(att_x, att_y, att_w, att_h);
    
    return attributes;
}

@end
