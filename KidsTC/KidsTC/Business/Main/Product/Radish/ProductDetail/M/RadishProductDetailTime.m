//
//  RadishProductDetailTime.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailTime.h"
#import "NSString+Category.h"

@implementation RadishProductDetailTime
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"times":[RadishProductDetailTimeItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _desc = [_desc isNotNull]?_desc:@"";
    return YES;
}
@end
