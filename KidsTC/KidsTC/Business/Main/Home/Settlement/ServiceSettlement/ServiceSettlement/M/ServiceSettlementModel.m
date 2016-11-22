//
//  ServiceSettlementModel.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementModel.h"
#import "YYKit.h"

@implementation ServiceSettlementModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {

    //考虑到普通服务
    if (!_data) {
        NSArray *datas = dic[@"data"];
        if (datas.count>0) {
            _data = [ServiceSettlementDataItem modelWithDictionary:datas.firstObject];
        }
    }
    
    return YES;
}
@end
