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
             @"store":[ProductDetailStore class],
             @"actors":[ProductDetailActor class],
             @"joinMember":[NSString class],
             @"place":[ProductDetailPlace class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _picRate = _picRate>0?_picRate:0.6;
    
    _isCanBuy = _status == 1;
    
    _showType = ProductDetailTwoColumnShowTypeDetail;
    
    _simpleName = [_simpleName isNotNull]?_simpleName:@"服务详情";
    
    _price = [NSString stringWithFormat:@"%@",@(_price.floatValue)];
    
    _originalPrice = [NSString stringWithFormat:@"%@",@(_originalPrice.floatValue)];
    
    [self setupInfo];
    
    [self setupAttApply];
    
    [self setupCommentList:dic];
    
    [self setupShareObj:dic];
    
    [self setupProductStandard];
    
    return YES;
}

- (void)setType:(ProductDetailType)type {
    _type = type;
    switch (type) {
        case ProductDetailTypeNormal:
        {
            _standardTitle = [_standardTitle isNotNull]?_standardTitle:@"已选套餐";
        }
            break;
        case ProductDetailTypeTicket:
        {
            [self setupTicketInfo];
            
            [self setupMoblies];
            
            [self setupTicketSynopsis];
            
            [self setupTicketPromise];
        }
            break;
        case ProductDetailTypeFree:
        {
            [self setupTricks];
            
            [self setupJoinMember];
        }
            break;
            default:
            break;
    }
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
        attPromote.color = COLOR_PINK;
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

- (void)setupProductStandard {
    if (_product_standards.count<1) {
        return;
    }
    __block BOOL has = NO;
    [_product_standards enumerateObjectsUsingBlock:^(ProductDetailStandard * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.productId isEqualToString:self.serveId]) {
            obj.selected = YES;
            has = YES;
            *stop = YES;
        }
    }];
    if (!has) {
        _product_standards.firstObject.selected = YES;
    }
}

#pragma mark - Ticket

- (void)setupTicketInfo {
    
    NSMutableAttributedString *attTicketContent = [[NSMutableAttributedString alloc] init];
    
    if ([_serveName isNotNull]) {
        NSMutableAttributedString *attServeName = [[NSMutableAttributedString alloc] initWithString:_serveName];
        attServeName.font = [UIFont systemFontOfSize:18];
        attServeName.color = [UIColor colorFromHexString:@"FFFFFF"];
        attServeName.lineSpacing = 8;
        [attTicketContent appendAttributedString:attServeName];
    }
    
    if (attTicketContent.length>0) {
        [attTicketContent appendAttributedString:self.lineFeedAttStr];
    }
    
    NSMutableAttributedString *attTicketInfo = [[NSMutableAttributedString alloc] init];
    
    if ([_theater.theaterName isNotNull]) {
        NSAttributedString *attTheaterName = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"场馆：%@",_theater.theaterName]];
        [attTicketInfo appendAttributedString:attTheaterName];
    }
    
    if (attTicketInfo.length>0) {
        [attTicketInfo appendAttributedString:self.lineFeedAttStr];
    }
    
    NSMutableString *localStr = [NSMutableString string];
    if ([_city isNotNull]) {
        [localStr appendString:[NSString stringWithFormat:@"%@/",_city]];
    }
    if ([_kind isNotNull]) {
        [localStr appendString:[NSString stringWithFormat:@"%@/",_kind]];
    }
    if ([_ticketTime isNotNull]) {
        [localStr appendString:_ticketTime];
    }
    if ([localStr isNotNull]) {
        NSAttributedString *attLocalStr = [[NSAttributedString alloc] initWithString:localStr];
        [attTicketInfo appendAttributedString:attLocalStr];
    }
    
    if (attTicketInfo.length>0) {
        [attTicketInfo appendAttributedString:self.lineFeedAttStr];
    }
    
    NSString *seeNumStr = [NSString stringWithFormat:@"%zd人想看 %zd人已看过",_wantSeeNum,_seeNum];
    NSAttributedString *attSeeNumStr = [[NSAttributedString alloc] initWithString:seeNumStr];
    [attTicketInfo appendAttributedString:attSeeNumStr];
    
    attTicketInfo.lineSpacing = 6;
    attTicketInfo.font = [UIFont systemFontOfSize:13];
    attTicketInfo.color = [[UIColor colorFromHexString:@"FFFFFF"] colorWithAlphaComponent:0.7];
    
    if (attTicketInfo.length>0) {
        [attTicketContent appendAttributedString:attTicketInfo];
    }
    
    if (attTicketContent.length>0) {
        [attTicketContent appendAttributedString:self.lineFeedAttStr];
    }
    
    if ([_priceDesc isNotNull]) {
        NSMutableAttributedString *attPriceDesc = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",_priceDesc]];
        attPriceDesc.font = [UIFont boldSystemFontOfSize:19];
        attPriceDesc.color = COLOR_PINK;
        [attTicketContent appendAttributedString:attPriceDesc];
    }
    
    _attTicketContent = attTicketContent;
}

- (NSAttributedString *)lineFeedAttStr {
    return [[NSAttributedString alloc] initWithString:@"\n"];
}

- (void)setupMoblies {
    NSString *phonesString =  _phone;
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

- (void)setupTicketSynopsis {
    if ([_synopsis isNotNull]) {
        NSMutableAttributedString *attSynopsis = [[NSMutableAttributedString alloc] initWithString:_synopsis];
        attSynopsis.lineSpacing = 10;
        attSynopsis.color = [UIColor colorFromHexString:@"555555"];
        attSynopsis.font = [UIFont systemFontOfSize:14];
        _attSynopsis = attSynopsis;
    }
}

- (void)setupTicketPromise {
    NSMutableAttributedString *attTicketPromise = [[NSMutableAttributedString alloc] init];
    if (_promise.isShowReal) {
        NSAttributedString *real = [self ticketPromise:@"ProductDetail_ticket_promise_real" tip:@"100%真票"];
        [attTicketPromise appendAttributedString:real];
    }
    if (_promise.isShowSafe) {
        NSAttributedString *safe = [self ticketPromise:@"ProductDetail_ticket_promise_safe" tip:@"安全交易"];
        [attTicketPromise appendAttributedString:safe];
    }
    if (_promise.isShowPayback) {
        NSAttributedString *payback = [self ticketPromise:@"ProductDetail_ticket_promise_payback" tip:@"无票赔付"];
        [attTicketPromise appendAttributedString:payback];
    }
    _attTicketPromise = attTicketPromise;
}

- (NSAttributedString *)ticketPromise:(NSString *)imageName tip:(NSString *)tip  {
    if ([imageName isNotNull] && [tip isNotNull]) {
        NSMutableAttributedString *attPromise = [[NSMutableAttributedString alloc] init];
        
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:imageName];
        attach.bounds = CGRectMake(0, -2, 14, 14);
        NSAttributedString *attachStr = [NSAttributedString attributedStringWithAttachment:attach];
        [attPromise appendAttributedString:attachStr];
        
        NSMutableAttributedString *attTip = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@   ",tip]];
        attTip.color = [UIColor colorFromHexString:@"555555"];
        attTip.font = [UIFont systemFontOfSize:14];
        [attPromise appendAttributedString:attTip];
        
        return attPromise;
    }
    return nil;
}

#pragma mark - Free

- (void)setupTricks {
    NSMutableString *trick = [NSMutableString string];
    [_tricks enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != 0) {
            [trick appendString:@"\n"];
        }
        [trick appendString:obj];
    }];
    NSMutableAttributedString *attTrick = [[NSMutableAttributedString alloc] initWithString:trick];
    attTrick.lineSpacing = 12;
    attTrick.font = [UIFont systemFontOfSize:14];
    attTrick.color = [UIColor colorFromHexString:@"666666"];
    _attTrickStr = [[NSAttributedString alloc] initWithAttributedString:attTrick];
}

- (void)setupJoinMember {
    if (self.joinMember.count>17) {
        NSMutableArray *ary = [NSMutableArray array];
        int count = 17;
        while (count>0) {
            count--;
            NSString *string = self.joinMember[count];
            if (![string isNotNull]) {
                string = @"ProductDetaiFreeJoin_place";
            }
            [ary addObject:string];
        }
        [ary addObject:@"ProductDetaiFreeJoin_more"];
        [ary addObject:@"ProductDetaiFreeJoin_place"];
        [ary addObject:@"ProductDetaiFreeJoin_place"];
        self.joinMember = [NSArray arrayWithArray:ary];
    }
}

@end
