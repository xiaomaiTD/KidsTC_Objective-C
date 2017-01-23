//
//  FlashBuyProductDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashBuyProductDetailData.h"

typedef enum : NSUInteger {
    FlashBuyProductDetailBaseCellActionTypeSegue = 1,
    FlashBuyProductDetailBaseCellActionTypeAddress,
    FlashBuyProductDetailBaseCellActionTypeRule,
    FlashBuyProductDetailBaseCellActionTypeChangeShowType,
    FlashBuyProductDetailBaseCellActionTypeComment,
    FlashBuyProductDetailBaseCellActionTypeMoreComment,
    FlashBuyProductDetailBaseCellActionTypeWebLoadFinish,
} FlashBuyProductDetailBaseCellActionType;

@class FlashBuyProductDetailBaseCell;
@protocol FlashBuyProductDetailBaseCellDelegate <NSObject>
- (void)flashBuyProductDetailBaseCell:(FlashBuyProductDetailBaseCell *)cell actionType:(FlashBuyProductDetailBaseCellActionType)type vlaue:(id)value;
@end

@interface FlashBuyProductDetailBaseCell : UITableViewCell
@property (nonatomic, strong) FlashBuyProductDetailData *data;
@property (nonatomic, weak) id<FlashBuyProductDetailBaseCellDelegate> delegate;
@end
