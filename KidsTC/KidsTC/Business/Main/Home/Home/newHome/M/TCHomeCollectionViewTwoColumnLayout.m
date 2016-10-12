//
//  TCHomeCollectionViewTwoColumnLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeCollectionViewTwoColumnLayout.h"

@implementation TCHomeCollectionViewTwoColumnLayout
- (void)prepareLayout {
    [super prepareLayout];
    self.minimumLineSpacing = _bottomSeparation;
    self.minimumInteritemSpacing = _centerSeparation;
    CGFloat size = (CGRectGetWidth(self.collectionView.bounds) - _centerSeparation)*0.5;
    self.itemSize = CGSizeMake(size, size);
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
@end
