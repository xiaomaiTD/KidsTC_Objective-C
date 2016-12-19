//
//  SettlementResultNewCollectionHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"

typedef enum : NSUInteger {
    SettlementResultNewCollectionHeaderActionTypeDetail = 1,
    SettlementResultNewCollectionHeaderActionTypeHome,
} SettlementResultNewCollectionHeaderActionType;

@class SettlementResultNewCollectionHeader;
@protocol SettlementResultNewCollectionHeaderDelegate <NSObject>
- (void)settlementResultNewCollectionHeader:(SettlementResultNewCollectionHeader *)header actionType:(SettlementResultNewCollectionHeaderActionType)type value:(id)value;
@end

@interface SettlementResultNewCollectionHeader : UICollectionReusableView
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<SettlementResultNewCollectionHeaderDelegate> delegate;
@end
