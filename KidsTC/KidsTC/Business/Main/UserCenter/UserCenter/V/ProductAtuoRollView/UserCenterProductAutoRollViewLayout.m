//
//  UserCenterProductAutoRollViewLayout.m
//  KidsTC
//
//  Created by 詹平 on 16/7/29.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UserCenterProductAutoRollViewLayout.h"

@implementation UserCenterProductAutoRollViewLayout
- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize=CGSizeMake(CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(self.collectionView.frame));
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
}
@end
