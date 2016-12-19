//
//  ProductOrderFreeDetailInfoBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderFreeDetailLotteryItem.h"
#import "ProductOrderFreeDetailData.h"

typedef enum : NSUInteger {
    ProductOrderFreeDetailInfoBaseCellActionTypeSegue = 50,
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
@property (nonatomic, strong) NSArray<ProductOrderFreeDetailLotteryItem* > *lotteryData;
@property (nonatomic, strong) ProductOrderFreeDetailData *infoData;
@property (nonatomic, weak) id<ProductOrderFreeDetailInfoBaseCellDelegate> delegate;
@end
