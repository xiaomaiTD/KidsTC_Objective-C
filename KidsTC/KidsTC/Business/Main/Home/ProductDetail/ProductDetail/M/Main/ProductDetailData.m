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
#import "Colours.h"

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
    
    _isCanBuy = _status == 1;
    
    _simpleName = [_simpleName isNotNull]?_simpleName:@"服务详情";
    
    _price = [NSString stringWithFormat:@"%@",@(_price.floatValue)];
    
    _originalPrice = [NSString stringWithFormat:@"%@",@(_originalPrice.floatValue)];
    
    [self setupInfo];
    
    [self setupAttApply];
    
    [self setupCommentList:dic];
    
    [self setupShareObj:dic];
    
    return YES;
}

- (void)setupInfo {
    
    if ([_serveName isNotNull]) {
        NSMutableAttributedString *attServeName = [[NSMutableAttributedString alloc] initWithString:_serveName];
        attServeName.font = [UIFont systemFontOfSize:17];
        attServeName.color = [UIColor colorFromHexString:@"222222"];
        attServeName.lineSpacing = 8;
        _attServeName = [[NSAttributedString alloc] initWithAttributedString:attServeName];
    }
    if ([_promote isNotNull]) {
        NSMutableAttributedString *attPromote = [[NSMutableAttributedString alloc] initWithString:_promote];
        attPromote.font = [UIFont systemFontOfSize:12];
        attPromote.color = [UIColor colorFromHexString:@"777777"];
        attPromote.lineSpacing = 6;
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
        attStr.color = [UIColor colorFromHexString:@"666666"];
        attStr.font = [UIFont systemFontOfSize:14];
        return [[NSAttributedString alloc] initWithAttributedString:attStr];
    }
    return nil;
}

- (void)setupCommentList:(NSDictionary *)data {
    NSArray *commentsArray = [data objectForKey:@"commentList"];
    NSMutableArray *commentItemsTempArray = [[NSMutableArray alloc] init];
    if ([commentsArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *singleDic in commentsArray) {
            CommentListItemModel *item = [[CommentListItemModel alloc] initWithRawData:singleDic];
            [commentItemsTempArray addObject:item];
        }
    }
    self.commentItemsArray = [NSArray arrayWithArray:commentItemsTempArray];
}

- (void)setupShareObj:(NSDictionary *)data {
    self.shareObject = [CommonShareObject shareObjectWithRawData:[data objectForKey:@"share"]];
    if (self.shareObject) {
        self.shareObject.identifier = _serveId;
        self.shareObject.followingContent = @"【童成】";
    }
}

@end
