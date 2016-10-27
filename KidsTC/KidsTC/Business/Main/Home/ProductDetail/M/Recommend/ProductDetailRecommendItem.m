//
//  ProductDetailRecommendItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailRecommendItem.h"
#import "NSString+Category.h"

@implementation ProductDetailRecommendItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _address = [_address isNotNull]?_address:@"";
    _distance = [_distance isNotNull]?_distance:@"";
    _priceStr = [NSString stringWithFormat:@"¥%@起",_price];
    _process = [_process isNotNull]?_process:@"";
    _locationStr = [NSString stringWithFormat:@"%@ %@",_address,_distance];
    return YES;
}
@end
