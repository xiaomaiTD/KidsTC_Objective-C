//
//  NormalProductDetailStandard.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailStandard.h"

@implementation NormalProductDetailStandard
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _priceStr = [NSString stringWithFormat:@"¥%@",_price];
    
    _isCanBuy = _status==1;
    
    return YES;
}
@end
