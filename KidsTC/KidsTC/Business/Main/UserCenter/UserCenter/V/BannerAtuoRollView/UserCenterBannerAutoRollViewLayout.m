//
//  UserCenterBannerAutoRollViewLayout.m
//  KidsTC
//
//  Created by 詹平 on 16/7/29.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UserCenterBannerAutoRollViewLayout.h"

@implementation UserCenterBannerAutoRollViewLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize=CGSizeMake(CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
}

@end
