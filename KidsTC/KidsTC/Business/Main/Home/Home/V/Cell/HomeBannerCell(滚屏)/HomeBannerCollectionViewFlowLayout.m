//
//  HomeBannerCollectionViewFlowLayout.m
//  KidsTC
//
//  Created by zhanping on 8/6/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "HomeBannerCollectionViewFlowLayout.h"

@implementation HomeBannerCollectionViewFlowLayout
- (void)prepareLayout{
    [super prepareLayout];
    CGFloat w = (int)CGRectGetWidth(self.collectionView.frame);
    CGFloat h = (int)CGRectGetHeight(self.collectionView.frame);
    self.itemSize = CGSizeMake(w, h);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
@end
