//
//  FlashBuyProductDetailData.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailData.h"
#import "NSString+Category.h"
#import "YYKit.h"
#import "ProductDetailSegueParser.h"

@implementation FlashBuyProductDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"priceConfigs":[FlashBuyProductDetailPriceConfig class],
             @"imgUrl":[NSString class],
             @"narrowImg":[NSString class],
             @"promotionLink":[FlashBuyProductDetailPromotionLink class],
             @"age":[NSString class],
             @"store":[FlashBuyProductDetailStore class],
             @"buyNotice":[FlashBuyProductDetailBuyNotice class],
             @"commentList":[FlashBuyProductDetailCommentListItem class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _showType = FlashBuyProductDetailShowTypeDetail;
    
    [self setupInfo];
    
    [self setupStore:dic];
    
    [self setupCommentList:dic];
    
    [self setupShareObj];
    
    [self setupSegueModel];
    
    [self setupCountDown];
    
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
        attPromote.color = [UIColor colorFromHexString:@"ff8888"];
        attPromote.lineSpacing = 6;
        _attPromote = [[NSAttributedString alloc] initWithAttributedString:attPromote];
    }
    if ([_content isNotNull]) {
        NSMutableAttributedString *attContent = [[NSMutableAttributedString alloc] initWithString:_content];
        attContent.font = [UIFont systemFontOfSize:14];
        attContent.color = [UIColor colorFromHexString:@"222222"];
        attContent.lineSpacing = 6;
        _attContent = [[NSAttributedString alloc] initWithAttributedString:attContent];
    }
}

- (void)setupStore:(NSDictionary *)data {
    NSArray *stores = [data objectForKey:@"store"];
    NSMutableArray<StoreListItemModel *> *storeModels = [NSMutableArray array];
    for (NSDictionary *dic in stores) {
        StoreListItemModel *storeListItemModel = [[StoreListItemModel alloc]initWithRawData:dic];
        if (storeListItemModel) [storeModels addObject:storeListItemModel];
    }
    self.storeModels = [NSArray arrayWithArray:storeModels];
}

- (void)setupCommentList:(NSDictionary *)data {

    NSArray *commentsArray = [data objectForKey:@"commentList"];
    if ([commentsArray isKindOfClass:[NSArray class]]) {
        NSMutableArray *commentItemsTempArray = [[NSMutableArray alloc] init];
        for (NSDictionary *singleDic in commentsArray) {
            CommentListItemModel *item = [[CommentListItemModel alloc] initWithRawData:singleDic];
            item.relationIdentifier = self.serveId;
            if(item) [commentItemsTempArray addObject:item];
        }
        self.commentItemsArray = [NSArray arrayWithArray:commentItemsTempArray];
    }
}

- (void)setupShareObj {
    self.shareObject = [CommonShareObject shareObjectWithTitle:_share.title description:_share.desc thumbImageUrl:[NSURL URLWithString:_share.imgUrl] urlString:_share.linkUrl];
}

- (void)setupSegueModel {
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productRedirect productId:_serveId channelId:@"0" openGroupId:nil];
}

- (void)setupCountDown {
    if (_isShowCountDown) {
        [self setupCountDownValueString];
        [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
    }
}

- (void)countDown{
    if (_countDownValue<0) {
        _countDownValueString = nil;
        [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
    }else{
        [self  setupCountDownValueString];
    }
}

- (void)setupCountDownValueString {
    if (_countDownValue<0){
        _countDownValueString = nil;
        return;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:_countDownValue];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:date options:0];
    NSString *time = nil;
    if (components.day>0){
        time = [NSString stringWithFormat:@"%.2zd天%.2zd时%.2zd分%.2zd秒",components.day,components.hour,components.minute,components.second];
    }else if (components.hour>0){
        time = [NSString stringWithFormat:@"%.2zd时%.2zd分%.2zd秒",components.hour,components.minute,components.second];
    }else if (components.minute>0){
        time = [NSString stringWithFormat:@"%.2zd分%.2zd秒",components.minute,components.second];
    }else if (components.second>=0){
        time = [NSString stringWithFormat:@"%.2zd秒",components.second];
    }
    _countDownValueString = [NSString stringWithFormat:@"%@：%@",_countDownStr,time];
    _countDownValue--;
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

@end
