//
//  ProductDetailTicketSelectSeatTime.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatTime.h"
#import "NSString+Category.h"
#import "YYKit.h"

@implementation ProductDetailTicketSelectSeatTime
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"seats":[ProductDetailTicketSelectSeatSeat class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self setupInfoStr];
    [_seats enumerateObjectsUsingBlock:^(ProductDetailTicketSelectSeatSeat * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.maxBuyNum>=1) {
            obj.selected = YES;
            *stop = YES;
        }
    }];
    return YES;
}

- (void)setupInfoStr {
    NSMutableAttributedString *attInfoStr = [[NSMutableAttributedString alloc] init];
    if ([_date isNotNull]) {
        NSAttributedString *dateStr = [[NSAttributedString alloc] initWithString:_date];
        [attInfoStr appendAttributedString:dateStr];
    }
    
    NSMutableString *twoStr = [NSMutableString string];
    if ([_dayOfWeek isNotNull]) {
        [twoStr appendString:_dayOfWeek];
    }
    if ([_minuteTime isNotNull]) {
        [twoStr appendString:[NSString stringWithFormat:@" %@",_minuteTime]];
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
