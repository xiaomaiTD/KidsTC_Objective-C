//
//  RadishProductOrderListItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListItem.h"
#import "NSString+Category.h"

@implementation RadishProductOrderListItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"orderBtns":[NSNumber class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupBtns];
    [self setupMoblies];
    if ([_orderNo isNotNull]) {
        NSDictionary *param = @{@"sid":_orderNo};
        _segueModel = [SegueModel modelWithDestination:SegueDestinationOrderRadishDetail paramRawData:param];
    }
    return YES;
}

- (void)setupBtns {
    NSMutableArray *btns = [NSMutableArray array];
    int count = (int)_orderBtns.count;
    for (int i = 1; i<=4; i++) {
        int index = count - i;
        if (index>=0) {
            NSNumber *obj = _orderBtns[index];
            RadishProductOrderListBtnType btnType = obj.integerValue;
            RadishProductOrderListBtn *btn = [RadishProductOrderListBtn btnWithType:btnType isHighLight:btnType == _defaultBtn];
            if (btn) [btns addObject:btn];
        }
    }
    _btns = [NSArray arrayWithArray:btns];
}

- (void)setupMoblies {
    NSString *phonesString =  _supplierMobie;
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

@end
