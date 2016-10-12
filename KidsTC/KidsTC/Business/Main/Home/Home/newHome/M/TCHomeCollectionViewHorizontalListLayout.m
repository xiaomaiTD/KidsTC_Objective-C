//
//  TCHomeCollectionViewHorizontalListLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeCollectionViewHorizontalListLayout.h"

@implementation TCHomeCollectionViewHorizontalListLayout
- (void)prepareLayout {
    [super prepareLayout];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    CGFloat size = CGRectGetWidth(self.collectionView.bounds)/3.5;
    self.itemSize = CGSizeMake(size, size);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
@end
