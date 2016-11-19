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
    _price = [NSString stringWithFormat:@"%@",@(_price.floatValue)];
    
    if (_maxBuyNum >= 1) {
        if (_minBuyNum<1) {
            _minBuyNum = 1;
        }
        if (_maxBuyNum<_minBuyNum) {
            _maxBuyNum = _minBuyNum;
        }
        _count = _minBuyNum;
    }
    
    [self setupInfoStr];
    return YES;
}

- (void)setupInfoStr {
    NSMutableAttributedString *attInfoStr = [[NSMutableAttributedString alloc] init];
    if ([_price isNotNull]) {
        NSAttributedString *priceStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %@",_price]];
        [attInfoStr appendAttributedString:priceStr];
    }
    
    NSMutableString *twoStr = [NSMutableString string];
    if ([_seat isNotNull]) {
        [twoStr appendString:_seat];
    }
    if ([twoStr isNotNull]) {
        if (attInfoStr.length>0) {
            [attInfoStr appendAttributedString:self.lineFeed];
        }
        NSAttributedString *attTwoStr = [[NSAttributedString alloc] initWithString:twoStr];
        [attInfoStr appendAttributedString:attTwoStr];
    }
    attInfoStr.lineSpacing = 6;
    attInfoStr.alignment = NSTextAlignmentCenter;
    attInfoStr.font = [UIFont systemFontOfSize:14];
    _attInfoStr = [[NSAttributedString alloc] initWithAttributedString:attInfoStr];
}

- (NSAttributedString *)lineFeed {
    return [[NSAttributedString alloc] initWithString:@"\n"];
}
@end
