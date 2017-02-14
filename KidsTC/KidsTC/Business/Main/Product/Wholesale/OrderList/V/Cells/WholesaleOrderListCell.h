//
//  WholesaleOrderListCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholesaleOrderListItem.h"

typedef enum : NSUInteger {
    WholesaleOrderListCellActionTypeConnectService = 1,//在线客服
    WholesaleOrderListCellActionTypeInvite = 2,//邀请好友
    WholesaleOrderListCellActionTypeShare = 3,//分享
    WholesaleOrderListCellActionTypePay = 4,//支付
    WholesaleOrderListCellActionTypeConsumeCode = 5,//消费码
    WholesaleOrderListCellActionTypeComment = 6,//评论
    WholesaleOrderListCellActionTypeCountDownOver,//倒计时结束
    
} WholesaleOrderListCellActionType;
@class WholesaleOrderListCell;
@protocol WholesaleOrderListCellDelegate <NSObject>
- (void)wholesaleOrderListCell:(WholesaleOrderListCell *)cell actionType:(WholesaleOrderListCellActionType)type value:(id)value;
@end

@interface WholesaleOrderListCell : UITableViewCell
@property (nonatomic, strong) WholesaleOrderListItem *item;
@property (nonatomic, weak) id<WholesaleOrderListCellDelegate> delegate;
@end
