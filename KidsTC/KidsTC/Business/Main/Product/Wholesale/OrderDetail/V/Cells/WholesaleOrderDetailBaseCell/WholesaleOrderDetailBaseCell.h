//
//  WholesaleOrderDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholesaleOrderDetailData.h"

typedef enum : NSUInteger {
    WholesaleOrderDetailBaseCellActionTypeRule = 1,//拼团玩法
    WholesaleOrderDetailBaseCellActionTypeLoadPartners,//加载参团记录
    WholesaleOrderDetailBaseCellActionTypeWebLoadFinish,//web加载完毕
    WholesaleOrderDetailBaseCellActionTypeBuy = 50,//去支付
    WholesaleOrderDetailBaseCellActionTypeMySale,//用户自己的拼团信息
    WholesaleOrderDetailBaseCellActionTypeProductHome,//更多拼团
    WholesaleOrderDetailBaseCellActionTypeShare,//分享
} WholesaleOrderDetailBaseCellActionType;
@class WholesaleOrderDetailBaseCell;
@protocol WholesaleOrderDetailBaseCellDelegate <NSObject>
- (void)wholesaleOrderDetailBaseCell:(WholesaleOrderDetailBaseCell *)cell actionType:(WholesaleOrderDetailBaseCellActionType)type value:(id)value;
@end

@interface WholesaleOrderDetailBaseCell : UITableViewCell
@property (nonatomic, strong) WholesaleOrderDetailData *data;
@property (nonatomic, weak) id<WholesaleOrderDetailBaseCellDelegate> delegate;
@end
