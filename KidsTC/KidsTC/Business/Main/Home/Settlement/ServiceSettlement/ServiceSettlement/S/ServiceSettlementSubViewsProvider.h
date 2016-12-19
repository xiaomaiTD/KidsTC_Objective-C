//
//  ServiceSettlementSubViewsProvider.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ServiceSettlementModel.h"
#import "ServiceSettlementBaseCell.h"
#import "ServiceSettlementToolBar.h"

@interface ServiceSettlementSubViewsProvider : NSObject
@property (nonatomic, assign) ProductDetailType type;
@property (nonatomic, strong) ServiceSettlementModel *model;
- (NSArray<NSArray<ServiceSettlementBaseCell *> *> *)sections;
- (ServiceSettlementToolBar *)tooBar;
- (void)nilSubViews;
@end
