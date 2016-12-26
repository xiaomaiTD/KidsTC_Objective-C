//
//  AreaAndAgeModel.m
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "AreaAndAgeModel.h"

@implementation AreaAndAgeListItem
- (instancetype)initWithName:(NSString *)name value:(NSString *)value{
    self = [super init];
    if (self) {
        self.Name = name;
        self.Value = value;
    }
    return self;
}

+(instancetype)itemWithName:(NSString *)name value:(NSString *)value{
    return [[self alloc]initWithName:name value:value];
}
@end

@implementation AreaAndAgeData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"Addr" : [AreaAndAgeListItem class],
             @"Age" : [AreaAndAgeListItem class]};
}
@end

@implementation AreaAndAgeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
