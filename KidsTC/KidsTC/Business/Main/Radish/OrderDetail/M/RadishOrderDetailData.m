//
//  RadishOrderDetailData.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailData.h"
#import "NSString+Category.h"
#import "Colours.h"
#import "ProductDetailSegueParser.h"

@implementation RadishOrderDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"remarks":[RadishOrderDetailRemark class],
             @"refunds":[RadishOrderDetailRefund class],
             @"orderUsedConsumeCode":[RadishOrderDetailConsumeCode class],
             @"orderBtns":[NSNumber class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupRemarks];
    [self setupOrderInfoStr];
    [self setupBtns];
    [self setupMoblies];
    [self setupSegueModel];
    [self setupCanShowBtn];
    [self setupUserRemarkStr];
    return YES;
}

- (void)setupRemarks {
    if (self.remarks.count>0) {
        __block NSMutableAttributedString *remaksAttStr = [[NSMutableAttributedString alloc]init];
        [self.remarks enumerateObjectsUsingBlock:^(RadishOrderDetailRemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.remark isNotNull]) {
                NSString *remarkStr = [NSString stringWithFormat:@"%@%@",idx==0?@"":@"\n",obj.remark];
                NSAttributedString *remarkAttStr = [[NSAttributedString alloc]initWithString:remarkStr];
                [remaksAttStr appendAttributedString:remarkAttStr];
            }
        }];
        if (remaksAttStr.length>0) {
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
            paragraph.lineSpacing = 8;
            NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                  NSForegroundColorAttributeName:[UIColor colorFromHexString:@"222222"],
                                  NSParagraphStyleAttributeName:paragraph};
            [remaksAttStr addAttributes:att range:NSMakeRange(0, remaksAttStr.length)];
            _remarksStr = remaksAttStr;
        }
    }
}

- (void)setupOrderInfoStr {
    NSMutableAttributedString *orderInfoAttStr = [[NSMutableAttributedString alloc]init];
    
    if ([_orderDetailDesc isNotNull]) {
        NSAttributedString *orderStateNameAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单状态：%@",_orderDetailDesc]];
        [orderInfoAttStr appendAttributedString:orderStateNameAttStr];
    }
    
    if ([_time isNotNull]) {
        NSAttributedString *timeAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@下单时间：%@",orderInfoAttStr.length>0?@"\n":@"",_time]];
        [orderInfoAttStr appendAttributedString:timeAttStr];
    }
    
    if ([_phone isNotNull]) {
        NSAttributedString *phoneAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n手机号码：%@",_phone]];
        [orderInfoAttStr appendAttributedString:phoneAttStr];
    }
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = 8;
    NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                          NSForegroundColorAttributeName:[UIColor colorFromHexString:@"222222"],
                          NSParagraphStyleAttributeName:paragraph};
    [orderInfoAttStr addAttributes:att range:NSMakeRange(0, orderInfoAttStr.length)];
    _orderInfoStr = orderInfoAttStr;
}

- (void)setupBtns {
    NSMutableArray *btns = [NSMutableArray array];
    int count = (int)_orderBtns.count;
    for (int i = 1; i<=4; i++) {
        int index = count - i;
        if (index>=0) {
            NSNumber *obj = _orderBtns[index];
            RadishOrderDetailBtnType btnType = obj.integerValue;
            RadishOrderDetailBtn *btn = [RadishOrderDetailBtn btnWithType:btnType isHighLight:btnType == _defaultBtn];
            if (btn) [btns addObject:btn];
        }
    }
    _btns = [NSArray arrayWithArray:btns];
}

- (void)setupMoblies {
    NSString *phonesString =  _supplierPhone;
    if ([phonesString isNotNull]) {
        NSMutableArray *phonesAry = [NSMutableArray new];
        if ([phonesString containsString:@";"]) {
            NSArray *ary = [phonesString componentsSeparatedByString:@";"];
            for (NSString *str in ary) {
                if (str && ![str isEqualToString:@""]) {
                    [phonesAry addObject:str];
                }
            }
        }else{
            if (phonesString && ![phonesString isEqualToString:@""]) {
                [phonesAry addObject:phonesString];
            }
        }
        _supplierPhones = [NSArray arrayWithArray:phonesAry];
    }
}

- (void)setupSegueModel {
    _productSegueModel = [ProductDetailSegueParser segueModelWithProductType:ProductDetailTypeNormal productId:_serveId channelId:_channelId openGroupId:nil];
}

- (void)setupCanShowBtn {
    switch (_onlineBespeakStatus) {
        case OrderBookingBespeakStatusCanBespeak:
        case OrderBookingBespeakStatusBespeaking:
        case OrderBookingBespeakStatusBespeakFail:
        case OrderBookingBespeakStatusBespeakSuccess:
        case OrderBookingBespeakStatusCancle:
        {
            _canShowButton = YES;
        }
            break;
        default:
        {
            _canShowButton = NO;
        }
            break;
    }
}

- (void)setupUserRemarkStr {
    if ([_userRemark isNotNull]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.lineSpacing = 8;
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                              NSForegroundColorAttributeName:[UIColor colorFromHexString:@"222222"],
                              NSParagraphStyleAttributeName:paragraph};
        _userRemarkStr = [[NSMutableAttributedString alloc]initWithString:_userRemark attributes:att];
    }
}

@end
