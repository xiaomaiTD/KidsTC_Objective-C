//
//  ProductStandardDetailData.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductStandardDetailData.h"

@implementation ProductStandardDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"stores" : [ProductStandardDetailStore class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _isCanBuy = _status==1;
    
    return YES;
}
@end
