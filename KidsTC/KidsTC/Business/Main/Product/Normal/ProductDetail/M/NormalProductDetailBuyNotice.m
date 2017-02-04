//
//  NormalProductDetailBuyNotice.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailBuyNotice.h"
#import "NSString+Category.h"

@implementation NormalProductDetailBuyNotice
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"notice":[NormalProductDetailNotice class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (![_title isNotNull]) _title = @"";
    return YES;
}
@end
