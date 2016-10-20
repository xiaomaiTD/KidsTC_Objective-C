//
//  TCHomeCollectionViewLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/17.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeCollectionViewLayout.h"

@implementation TCHomeCollectionViewLayout
- (void)prepareLayout {
    [super prepareLayout];
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    CGFloat w = CGRectGetWidth(self.collectionView.bounds);
    CGFloat h = CGRectGetHeight(self.collectionView.bounds);
    self.itemSize = CGSizeMake(w, h);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
@end
