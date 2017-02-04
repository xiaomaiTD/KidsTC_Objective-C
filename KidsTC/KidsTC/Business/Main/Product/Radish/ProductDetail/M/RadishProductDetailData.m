//
//  RadishProductDetailData.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailData.h"
#import "NSString+Category.h"
#import "YYKit.h"


@implementation RadishProductDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"applyContent":[NSString class],
             @"promotionLink":[RadishProductDetailPromotionLink class],
             @"buyNotice":[RadishProductDetailBuyNotice class],
             @"narrowImg":[NSString class],
             @"commentList":[RadishProductDetailCommentItem class],
             @"product_standards":[RadishProductDetailStandard class],
             @"store":[RadishProductDetailStore class],
             @"place":[RadishProductDetailPlace class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (_picRate<=0) _picRate = 0.6;
    
    _isCanBuy = _status == 1;
    
    _showType = RadishProductDetailTwoColumnShowTypeDetail;
    
    _simpleName = [_simpleName isNotNull]?_simpleName:@"服务详情";
    
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
        attPromote.color = COLOR_PINK;
        attPromote.lineSpacing = 6;
        _attPromote = [[NSAttributedString alloc] initWithAttributedString:attPromote];
    }
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
        self.shareObject.identifier = _serverId;
        self.shareObject.followingContent = @"【童成】";
    }
}

@end
