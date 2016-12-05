//
//  ProductOrderListAllTitleCollectionCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderListAllTitleRowItem.h"

@interface ProductOrderListAllTitleCollectionCell : UICollectionViewCell
@property (nonatomic, assign) ProductOrderListAllTitleRowItem *item;
@property (nonatomic, copy) void (^actionBlock)(ProductOrderListAllTitleRowItem *item);
@end
