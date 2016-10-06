//
//  ServiceDetailConfigModel.m
//  KidsTC
//
//  Created by zhanping on 6/14/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ServiceDetailConfigModel.h"

@implementation ServiceDetailConfigStoreItem

@end

@implementation ServiceDetailConfigData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"stores" : [ServiceDetailConfigStoreItem class]};
}
@end

@implementation ServiceDetailConfigModel

@end
