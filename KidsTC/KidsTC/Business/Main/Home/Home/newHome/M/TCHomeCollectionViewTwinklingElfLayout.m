//
//  TCHomeCollectionViewTwinklingElfLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeCollectionViewTwinklingElfLayout.h"

@implementation TCHomeCollectionViewTwinklingElfLayout
- (void)prepareLayout{
    [super prepareLayout];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    CGFloat size = CGRectGetWidth(self.collectionView.bounds)/4;
    self.itemSize = CGSizeMake(size, size);
}
@end
