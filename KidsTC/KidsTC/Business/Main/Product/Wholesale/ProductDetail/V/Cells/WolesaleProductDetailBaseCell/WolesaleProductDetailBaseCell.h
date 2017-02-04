//
//  WolesaleProductDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WolesaleProductDetailData.h"

typedef enum : NSUInteger {
    WolesaleProductDetailBaseCellActionTypeRule = 1,//活动拼团
    WolesaleProductDetailBaseCellActionTypeJoinOther,//参加其他团
    WolesaleProductDetailBaseCellActionTypeTime,//显示时间
    WolesaleProductDetailBaseCellActionTypeAddress,//显示位置
    WolesaleProductDetailBaseCellActionTypeWebLoadFinish,//web加载完毕
    WolesaleProductDetailBaseCellActionTypeOtherProduct,//其他拼团
    WolesaleProductDetailBaseCellActionTypeLoadTeam,//加载参加其他团
    WolesaleProductDetailBaseCellActionTypeLoadOtherProduct,//加载其他拼团
} WolesaleProductDetailBaseCellActionType;

@class WolesaleProductDetailBaseCell;
@protocol WolesaleProductDetailBaseCellDelegate <NSObject>
- (void)wolesaleProductDetailBaseCell:(WolesaleProductDetailBaseCell *)cell actionType:(WolesaleProductDetailBaseCellActionType)type value:(id)value;
@end

@interface WolesaleProductDetailBaseCell : UITableViewCell
@property (nonatomic, strong) WolesaleProductDetailData *data;
@property (nonatomic, weak) id<WolesaleProductDetailBaseCellDelegate> delegate;
@end
