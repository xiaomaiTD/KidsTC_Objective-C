//
//  ProductDetailData.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailData.h"
#import "NSAttributedString+YYText.h"
#import "NSString+Category.h"

@implementation ProductDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"applyContent":[NSString class],
             @"promotionLink":[ProductDetailPromotionLink class],
             @"buyNotice":[ProductDetailBuyNotice class],
             @"narrowImg":[NSString class],
             @"commentList":[ProduceDetialCommentItem class],
             @"coupon_provide":[ProdectDetailCoupon class],
             @"fullCut":[NSString class],
             @"coupons":[NSString class],
             @"product_standards":[ProductDetailStandard class],
             @"store":[ProductDetailStore class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _picRate = _picRate>0?_picRate:0.6;
    
    [self setupInfo];
    
    [self setupAttApply];
    
    return YES;
}

- (void)setupInfo {
    
    if ([_serveName isNotNull]) {
        NSMutableAttributedString *attServeName = [[NSMutableAttributedString alloc] initWithString:_serveName];
        attServeName.font = [UIFont systemFontOfSize:19];
        attServeName.color = [UIColor blackColor];
        attServeName.lineSpacing = 6;
        _attServeName = [[NSAttributedString alloc] initWithAttributedString:attServeName];
    }
    if ([_promote isNotNull]) {
        NSMutableAttributedString *attPromote = [[NSMutableAttributedString alloc] initWithString:_promote];
        attPromote.font = [UIFont systemFontOfSize:17];
        attPromote.color = [UIColor darkGrayColor];
        attPromote.lineSpacing = 4;
        
        
        [_promotionLink enumerateObjectsUsingBlock:^(ProductDetailPromotionLink * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [_promote rangeOfString:obj.linkKey];
            
        }];
        _attPromote = [[NSAttributedString alloc] initWithAttributedString:attPromote];
    }
    
    _priceStr = [NSString stringWithFormat:@"¥%@",_price];
}

- (void)setupAttApply {
    
    NSMutableArray<NSAttributedString *> *attApply = [NSMutableArray array];
    [_applyContent enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSAttributedString *attStr = [self attStr:obj];
        if (attStr.length>0) {
            [attApply addObject:attStr];
        }
    }];
    _attApply = [NSArray arrayWithArray:attApply];
}

- (NSAttributedString *)attStr:(NSString *)str {
    if ([str isNotNull]) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        attStr.lineSpacing = 4;
        attStr.color = [UIColor darkGrayColor];
        attStr.font = [UIFont systemFontOfSize:17];
        return [[NSAttributedString alloc] initWithAttributedString:attStr];
    }
    return nil;
}
@end
