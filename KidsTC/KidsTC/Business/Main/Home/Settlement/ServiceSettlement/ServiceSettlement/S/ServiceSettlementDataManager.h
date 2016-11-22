//
//  ServiceSettlementDataManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import "ServiceSettlementModel.h"
#import "PayModel.h"

@interface ServiceSettlementDataManager : NSObject
singleH(ServiceSettlementDataManager)
@property (nonatomic, assign) ProductDetailType type;
- (void)loadDataWithParam:(NSDictionary *)param
             successBlock:(void(^)(ServiceSettlementModel *model))successBlock
             failureBlock:(void(^)(NSError *error))failureBlock;

- (void)placeOrderWithParam:(NSDictionary *)param
               successBlock:(void(^)(PayModel *model))successBlock
               failureBlock:(void(^)(NSError *error))failureBlock;
@end
