//
//  StrategyCollectionViewFlowLayout.m
//  KidsTC
//
//  Created by zhanping on 6/6/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyCollectionViewFlowLayout.h"

@implementation StrategyCollectionViewFlowLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (void)prepareLayout{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat width = CGRectGetWidth(self.collectionView.bounds);
    CGFloat height = CGRectGetHeight(self.collectionView.bounds);
    self.itemSize = CGSizeMake(width, height);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}
@end
