//
//  ProductOrderTicketDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderTicketDetailData.h"

typedef enum : NSUInteger {
    
    ProductOrderTicketDetailBaseCellActionTypeSegue = 50,//通用跳转
    ProductOrderTicketDetailBaseCellActionTypeDeliberCall,//订单电话
    ProductOrderTicketDetailBaseCellActionTypeAddress,//地址
    ProductOrderTicketDetailBaseCellActionTypeContact,//联系商家
    
} ProductOrderTicketDetailBaseCellActionType;

@class ProductOrderTicketDetailBaseCell;
@protocol ProductOrderTicketDetailBaseCellDelegate <NSObject>
- (void)productOrderTicketDetailBaseCell:(ProductOrderTicketDetailBaseCell *)cell actionType:(ProductOrderTicketDetailBaseCellActionType)type value:(id)value;
@end

@interface ProductOrderTicketDetailBaseCell : UITableViewCell
@property (nonatomic, weak) ProductOrderTicketDetailData *data;
@property (nonatomic, weak) id<ProductOrderTicketDetailBaseCellDelegate> delegate;
@end
