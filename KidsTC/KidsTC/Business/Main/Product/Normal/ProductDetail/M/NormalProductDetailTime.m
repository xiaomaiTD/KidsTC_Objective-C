//
//  NormalProductDetailTime.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailTime.h"
#import "NSString+Category.h"
@implementation NormalProductDetailTime
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"times":[NormalProductDetailTimeItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _desc = [_desc isNotNull]?_desc:@"";
    return YES;
}
@end
