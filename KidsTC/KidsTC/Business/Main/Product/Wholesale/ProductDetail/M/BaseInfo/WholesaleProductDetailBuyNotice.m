//
//  WholesaleProductDetailBuyNotice.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleProductDetailBuyNotice.h"
#import "NSString+Category.h"

@implementation WholesaleProductDetailBuyNotice
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"notice" : [WholesaleProductDetailNotice class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _title = [_title isNotNull]?_title:@"购买须知";
    
    return YES;
}
@end
