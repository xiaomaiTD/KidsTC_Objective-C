//
//  ProductOrderTicketDetailData.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailData.h"
#import "NSString+Category.h"
#import "Colours.h"

@implementation ProductOrderTicketDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"remarks":[ProductOrderTicketDetailRemark class],
             @"refunds":[ProductOrderTicketDetailRefund class],
             @"seats":[ProductOrderTicketDetailSeat class],
             @"orderBtns":[NSNumber class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupRemarks];
    [self setupBtns];
    [self setupMoblies];
    [self setupSegueModel];
    
    return YES;
}

- (void)setupRemarks {
    if (self.remarks.count>0) {
        __block NSMutableAttributedString *remaksAttStr = [[NSMutableAttributedString alloc]init];
        [self.remarks enumerateObjectsUsingBlock:^(ProductOrderTicketDetailRemark *obj, NSUInteger idx, BOOL *stop) {
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

- (void)setupBtns {
    NSMutableArray *btns = [NSMutableArray array];
    int count = (int)_orderBtns.count;
    for (int i = 1; i<=4; i++) {
        int index = count - i;
        if (index>=0) {
            NSNumber *obj = _orderBtns[index];
            ProductOrderTicketDetailBtnType btnType = obj.integerValue;
            ProductOrderTicketDetailBtn *btn = [ProductOrderTicketDetailBtn btnWithType:btnType isHighLight:btnType == _defaultBtn];
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
    if ([_productNo isNotNull]) {
        if (![_chId isNotNull]) {
            _chId = @"0";
        }
        NSDictionary *param = @{@"pid":_productNo,
                                @"cid":_chId,
                                @"type":@(ProductDetailTypeTicket)};
        _productSegueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:param];
    }
}
@end
