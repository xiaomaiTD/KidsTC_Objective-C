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
    WholesaleOrderDetailBaseCellActionType01,
    WholesaleOrderDetailBaseCellActionType02,
} WholesaleOrderDetailBaseCellActionType;
@class WholesaleOrderDetailBaseCell;
@protocol WholesaleOrderDetailBaseCellDelegate <NSObject>
- (void)wholesaleOrderDetailBaseCell:(WholesaleOrderDetailBaseCell *)cell actionType:(WholesaleOrderDetailBaseCellActionType)type value:(id)value;
@end

@interface WholesaleOrderDetailBaseCell : UITableViewCell
@property (nonatomic, strong) WholesaleOrderDetailData *data;
@property (nonatomic, weak) id<WholesaleOrderDetailBaseCellDelegate> delegate;
@end
