//
//  TCStoreDetailProductPackage.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailProductPackage.h"
#import "NSString+Category.h"

@implementation TCStoreDetailProductPackage
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"products":[TCStoreDetailProductPackageItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (![_title isNotNull]) _title = @"活动套餐";
    
    return YES;
}
@end
