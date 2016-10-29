//
//  ProductDetailStandard.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailStandard.h"

@implementation ProductDetailStandard
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _priceStr = [NSString stringWithFormat:@"¥%@",_price];
    
    _isCanBuy = _status==1;
    
    return YES;
}
@end
