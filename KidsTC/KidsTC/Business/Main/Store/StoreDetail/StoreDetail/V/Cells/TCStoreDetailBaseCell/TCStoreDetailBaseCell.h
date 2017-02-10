//
//  TCStoreDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCStoreDetailData.h"

typedef enum : NSUInteger {
    TCStoreDetailBaseCellActionTypeCollect = 1,
    TCStoreDetailBaseCellActionTypePhone,
    TCStoreDetailBaseCellActionTypePreferentialPackageMore,
    TCStoreDetailBaseCellActionTypeCoupon,
    TCStoreDetailBaseCellActionTypeCouponMore,
    TCStoreDetailBaseCellActionTypeSegue,
    TCStoreDetailBaseCellActionTypePackageMore,
    TCStoreDetailBaseCellActionTypeWebLoadFinish,
    TCStoreDetailBaseCellActionTypeCommentWrite,
    TCStoreDetailBaseCellActionTypeComment,
    TCStoreDetailBaseCellActionTypeCommentMore,
    TCStoreDetailBaseCellActionTypeFacility,
} TCStoreDetailBaseCellActionType;

@class TCStoreDetailBaseCell;
@protocol TCStoreDetailBaseCellDelegate <NSObject>
- (void)tcStoreDetailBaseCell:(TCStoreDetailBaseCell *)cell actionType:(TCStoreDetailBaseCellActionType)type value:(id)value;
@end

@interface TCStoreDetailBaseCell : UITableViewCell
@property (nonatomic, weak) id<TCStoreDetailBaseCellDelegate> delegate;
@property (nonatomic, strong) TCStoreDetailData *data;
@end
