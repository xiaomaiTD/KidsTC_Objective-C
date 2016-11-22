//
//  ServiceSettlementModel.h
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceSettlementDataItem.h"

@interface ServiceSettlementModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ServiceSettlementDataItem *data;
@property (nonatomic, strong) NSString *soleid;
@end


