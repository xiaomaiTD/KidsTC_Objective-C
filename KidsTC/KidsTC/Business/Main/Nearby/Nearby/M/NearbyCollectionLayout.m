//
//  NearbyCollectionLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCollectionLayout.h"

@implementation NearbyCollectionLayout

- (void)prepareLayout {
    self.itemSize = self.collectionView.bounds.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
}

@end
