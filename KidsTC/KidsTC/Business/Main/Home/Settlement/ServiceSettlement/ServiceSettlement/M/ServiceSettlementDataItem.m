//
//  ServiceSettlementDataItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementDataItem.h"
#import "YYKit.h"
#import "NSString+Category.h"
#import "Colours.h"

@implementation ServiceSettlementDataItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"coupon" : [ServiceSettlementCouponItem class],
             @"seats" : [ServiceSettlementSeat class],
             @"place":[ServiceSettlementPlace class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self dataConversion:dic];
    
    
    
    return YES;
}

- (void)dataConversion:(NSDictionary *)dic {
    if (_minBuyNum<1) {
        _minBuyNum = 1;
    }
    if (_maxBuyNum<_minBuyNum) {
        _maxBuyNum = _minBuyNum;
    }
    
    _price = [NSString stringWithFormat:@"%@",@(_price.floatValue)];
    _payPrice = [NSString stringWithFormat:@"%@",@(_payPrice.floatValue)];
    _totalPrice = [NSString stringWithFormat:@"%@",@(_totalPrice.floatValue)];
    
    if (!_imgUrl) _imgUrl = [NSString stringWithFormat:@"%@",dic[@"img"]];
    if (!_channelId) _channelId = [NSString stringWithFormat:@"%@",dic[@"chid"]];
    if (!_serveId) _serveId = [NSString stringWithFormat:@"%@",dic[@"productNo"]];
    if (!_serveName) _serveName = [NSString stringWithFormat:@"%@",dic[@"productName"]];
    if (!_usescorenum) _usescorenum = [dic[@"useScoreNum"] integerValue];
    if (!_scorenum) _scorenum = [dic[@"totalScoreNum"] integerValue];
    if (!_coupon) _coupon = [NSArray modelArrayWithClass:[ServiceSettlementCouponItem class] json:dic[@"coupons"]];
    if (!_maxCoupon) _maxCoupon = [ServiceSettlementCouponItem modelWithDictionary:dic[@"bestCoupon"]];
    if (!_pay_type) _pay_type = [ServiceSettlementPayType modelWithDictionary:dic[@"payChannel"]];
    if (!_userAddress) _userAddress = [UserAddressManageDataItem modelWithDictionary:dic[@"userAddressInfo"]];
    if (!_takeTicketWay) _takeTicketWay = ServiceSettlementTakeTicketWayCar;
}

- (void)setType:(ProductDetailType)type {
    _type = type;
    switch (type) {
        case ProductDetailTypeNormal:
        {
            [self setupNormalServiceInfo];
        }
            break;
        case ProductDetailTypeTicket:
        {
            [self setupTicketServiceInfo];
        }
            break;
        default:
            break;
    }
}

- (void)setupNormalServiceInfo {
    
    NSMutableAttributedString *attServiceInfo = [[NSMutableAttributedString alloc]init];
    if ([_serveName isNotNull]) {
        NSMutableAttributedString *nameAttStr = [[NSMutableAttributedString alloc]initWithString:_serveName];
        nameAttStr.color = [UIColor colorFromHexString:@"222222"];
        nameAttStr.font = [UIFont systemFontOfSize:14];
        [attServiceInfo appendAttributedString:nameAttStr];
    }
    if (attServiceInfo.length>0) {
        [attServiceInfo appendAttributedString:self.lineFeed];
    }
    if ([_useValidTimeDesc isNotNull]) {
        NSMutableAttributedString *timeAttStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"使用有效期：%@",_useValidTimeDesc]];
        timeAttStr.color = [UIColor colorFromHexString:@"616161"];
        timeAttStr.font = [UIFont systemFontOfSize:12];
        [attServiceInfo appendAttributedString:timeAttStr];
    }
    if (attServiceInfo.length>0) {
        [attServiceInfo appendAttributedString:self.lineFeed];
    }
    if ([_price isNotNull]) {
        NSMutableAttributedString *priceAttStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_price]];
        priceAttStr.color = COLOR_PINK;
        priceAttStr.font = [UIFont systemFontOfSize:17];
        [attServiceInfo appendAttributedString:priceAttStr];
        
        NSMutableAttributedString *countAttStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"x%zd",_count]];
        countAttStr.color = [UIColor colorFromHexString:@"616161"];
        countAttStr.font = [UIFont systemFontOfSize:12];
        [attServiceInfo appendAttributedString:countAttStr];
    }
    if (attServiceInfo.length>0) {
        attServiceInfo.lineSpacing = 8;
    }
    
    _attServiceInfo = [[NSAttributedString alloc] initWithAttributedString:attServiceInfo];
}

- (void)setupTicketServiceInfo {
    
    NSMutableAttributedString *attServiceInfo = [[NSMutableAttributedString alloc]init];
    if ([_serveName isNotNull]) {
        NSMutableAttributedString *nameAttStr = [[NSMutableAttributedString alloc]initWithString:_serveName];
        nameAttStr.color = [UIColor colorFromHexString:@"222222"];
        nameAttStr.font = [UIFont systemFontOfSize:14];
        [attServiceInfo appendAttributedString:nameAttStr];
    }
    
    if ([_showTime.showStr isNotNull]) {
        if (attServiceInfo.length>0) [attServiceInfo appendAttributedString:self.lineFeed];
        NSMutableAttributedString *timeAttStr = [[NSMutableAttributedString alloc]initWithString:_showTime.showStr];
        timeAttStr.color = [UIColor colorFromHexString:@"616161"];
        timeAttStr.font = [UIFont systemFontOfSize:12];
        [attServiceInfo appendAttributedString:timeAttStr];
    }
    
    if ([_theater isNotNull]) {
        if (attServiceInfo.length>0) [attServiceInfo appendAttributedString:self.lineFeed];
        NSMutableAttributedString *theaterAttStr = [[NSMutableAttributedString alloc]initWithString:_theater];
        theaterAttStr.color = [UIColor colorFromHexString:@"616161"];
        theaterAttStr.font = [UIFont systemFontOfSize:12];
        [attServiceInfo appendAttributedString:theaterAttStr];
    }
    
    if (attServiceInfo.length>0) attServiceInfo.lineSpacing = 8;
    
    _attServiceInfo = [[NSAttributedString alloc] initWithAttributedString:attServiceInfo];
}

- (NSAttributedString *)lineFeed {
    return [[NSAttributedString alloc] initWithString:@"\n"];
}

@end
