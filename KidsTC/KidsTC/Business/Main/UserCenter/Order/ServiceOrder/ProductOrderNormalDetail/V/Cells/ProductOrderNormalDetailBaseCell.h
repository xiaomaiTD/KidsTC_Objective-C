//
//  ProductOrderNormalDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderNormalDetailData.h"

typedef enum : NSUInteger {
    
    ProductOrderNormalDetailBaseCellActionTypeSegue = 50,//通用跳转
    ProductOrderNormalDetailBaseCellActionTypeDeliberCall,//订单电话
    ProductOrderNormalDetailBaseCellActionTypeBooking,//我要预约
    ProductOrderNormalDetailBaseCellActionTypeBookingMustEdit,//我要预约，编辑
    ProductOrderNormalDetailBaseCellActionTypeContact,//联系商家
} ProductOrderNormalDetailBaseCellActionType;

@class ProductOrderNormalDetailBaseCell;
@protocol ProductOrderNormalDetailBaseCellDelegate <NSObject>
- (void)productOrderNormalDetailBaseCell:(ProductOrderNormalDetailBaseCell *)cell actionType:(ProductOrderNormalDetailBaseCellActionType)type value:(id)value;
@end

@interface ProductOrderNormalDetailBaseCell : UITableViewCell
@property (nonatomic, weak) ProductOrderNormalDetailData *data;
@property (nonatomic, weak) id<ProductOrderNormalDetailBaseCellDelegate> delegate;
@end
