//
//  ProductDetailTwoColumnTableViewBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailConsultItem.h"

typedef enum : NSUInteger {
    ProductDetailTwoColumnTableViewBaseCellActionTypeAddNew = 1//新增咨询
} ProductDetailTwoColumnTableViewBaseCellActionType;

@class ProductDetailTwoColumnTableViewBaseCell;
@protocol ProductDetailTwoColumnTableViewBaseCellDelegate <NSObject>
- (void)productDetailTwoColumnTableViewBaseCell:(ProductDetailTwoColumnTableViewBaseCell *)cell actionType:(ProductDetailTwoColumnTableViewBaseCellActionType)type value:(id)value;
@end

@interface ProductDetailTwoColumnTableViewBaseCell : UITableViewCell
@property (nonatomic, strong) ProductDetailConsultItem *item;
@property (nonatomic, weak) id<ProductDetailTwoColumnTableViewBaseCellDelegate> delegate;
@end
