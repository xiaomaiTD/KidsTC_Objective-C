//
//  ProductOrderFreeDetailInfoBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderFreeDetailLotteryData.h"
#import "ProductOrderFreeDetailData.h"

typedef enum : NSUInteger {
    ProductOrderFreeDetailInfoBaseCellActionTypeProduct = 50,
    ProductOrderFreeDetailInfoBaseCellActionTypeStore,
    ProductOrderFreeDetailInfoBaseCellActionTypeAddress,
    ProductOrderFreeDetailInfoBaseCellActionTypeDate,
    ProductOrderFreeDetailInfoBaseCellActionTypeMoreLottery,
} ProductOrderFreeDetailInfoBaseCellActionType;

@class ProductOrderFreeDetailInfoBaseCell;
@protocol ProductOrderFreeDetailInfoBaseCellDelegate <NSObject>
- (void)productOrderFreeDetailInfoBaseCell:(ProductOrderFreeDetailInfoBaseCell *)cell actionType:(ProductOrderFreeDetailInfoBaseCellActionType)type value:(id)value;
@end


@interface ProductOrderFreeDetailInfoBaseCell : UITableViewCell
@property (nonatomic, strong) ProductOrderFreeDetailLotteryData *lotteryData;
@property (nonatomic, strong) ProductOrderFreeDetailData *infoData;
@property (nonatomic, weak) id<ProductOrderFreeDetailInfoBaseCellDelegate> delegate;
@end
