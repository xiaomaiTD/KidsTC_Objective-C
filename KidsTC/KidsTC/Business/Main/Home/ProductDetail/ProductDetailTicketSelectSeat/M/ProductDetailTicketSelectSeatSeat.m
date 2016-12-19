//
//  ProductDetailTicketSelectSeatSeat.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatSeat.h"
#import "NSString+Category.h"
#import "YYKit.h"

@implementation ProductDetailTicketSelectSeatSeat
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    //_price = [NSString stringWithFormat:@"%@",@(_price.floatValue)];
    //_orignalPrice = [NSString stringWithFormat:@"%@",@(_orignalPrice.floatValue)];
    if (_maxBuyNum >= 1) {
        if (_minBuyNum<1) {
            _minBuyNum = 1;
        }
        if (_maxBuyNum<_minBuyNum) {
            _maxBuyNum = _minBuyNum;
        }
        _count = _minBuyNum;
    }
    return YES;
}
@end
