//
//  ProductOrderTicketDetailModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailModel.h"

@implementation ProductOrderTicketDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
