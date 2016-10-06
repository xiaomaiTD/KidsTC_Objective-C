//
//  HomeDataManager.m
//  KidsTC
//
//  Created by ling on 16/7/18.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeDataManager.h"
#import "GHeader.h"
#import "HomeViewController.h"
#import "UILabel+Additions.h"

static NSString *kLocalFileName = @"home.plist";

static NSString *kLocalCacheDate = @"localSaveDate";

#define LOCAL_CACHE_TIME (100)
#define pageCount 10
@interface HomeDataManager()

@property (nonatomic, strong) HomeModel *customerRecommendHomeModel;
@property (nonatomic, strong) NSMutableArray *recArr;//为您推荐数组
@property (nonatomic, assign) NSInteger page;
@end

@implementation HomeDataManager

singleM(HomeDataManager)

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}


#pragma mark Public methods
- (void)refreshHomeDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    self.page = 0;
    //请求首页数据
    Role *role = [User shareUser].role;
    NSDictionary *param = @{@"type":role.roleIdentifierString};
    [Request startWithName:@"GET_PAGE_HOME" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        self.homeModel = [HomeModel modelWithDictionary:dic];
        self.dataArr = self.homeModel.allFloors;
        [self getCustomerRecommendWithSucceed:^(NSDictionary *data) {
            if (succeed) succeed(nil);
        } failure:^(NSError *error) {
            if (succeed) succeed(nil);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self getCustomerRecommendWithSucceed:^(NSDictionary *data) {
            if (succeed) succeed(nil);
        } failure:^(NSError *error) {
            if (failure) failure(nil);
        }];
    }];
}

- (void)getCustomerRecommendWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {//单独请求推荐数据 上拉时
    self.page ++;
    NSDictionary *param = @{@"populationType":[[User shareUser].role roleIdentifierString],
                            @"page":@(self.page),
                            @"pageCount":@(pageCount)};
    [Request startWithName:@"GET_PAGE_RECOMMEND_NEW_PRODUCE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadCustomerRecommendSucceed:dic];
        if (succeed) succeed(nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadCustomerRecommendFailed:error];
        failure(nil);
    }];
}

- (void)loadCustomerRecommendSucceed:(NSDictionary *)data {//更新推荐数组
    if (![data[@"data"] isKindOfClass:[NSArray class]]) return;
    
    NSArray *dataArr = data[@"data"];
    self.recArr = [NSMutableArray array];
    for (int i = 0; i < dataArr.count; i ++) {
        if (![dataArr[i] isKindOfClass:[NSDictionary class]]) return;
        HomeNewRecItem *recItem = [HomeNewRecItem modelWithDictionary:dataArr[i]];
        HomeFloorsItem *floor = [self floorItemWithRec:recItem];
        if (!floor) return;
        [self.recArr addObject:floor];
    }
    
    NSMutableArray *mtArr = [NSMutableArray arrayWithArray:self.dataArr];
    [mtArr addObjectsFromArray:self.recArr];
    self.dataArr = mtArr.copy;
}

- (void)loadCustomerRecommendFailed:(NSError *)error {
    self.noMoreData = YES;
}

- (HomeFloorsItem *)floorItemWithRec:(HomeNewRecItem *)recItem{
    if (!recItem) return nil;
    //转化为首页一致数据模型
    HomeFloorsItem *recFloor = [[HomeFloorsItem alloc] init];
    
    recFloor.contentType =  HomeContentCellTypeRecommend;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    recFloor.ratio = [numberFormatter numberFromString:recItem.picRate];
    
    CGFloat height = recItem.picRate.floatValue * SCREEN_WIDTH + 10;//为"热销活动"标签预留10间隙
    height+=10;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.72, 9999)];
    label.numberOfLines = 2;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 6;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font = [UIFont systemFontOfSize:17];
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle,
                                 NSFontAttributeName:font};
    NSMutableAttributedString *mutableTitleStr = [[NSMutableAttributedString alloc]initWithString:recItem.serveName attributes:attributes];
//    CGSize size = CGSizeMake(SCREEN_WIDTH*0.72, 999);
//    CGFloat serveNameH = [mutableTitleStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
//    serveNameH = serveNameH>50?50:0;
    
    label.attributedText = mutableTitleStr;
    [label sizeToFit];
    height += label.frame.size.height;
    height+=10;
//    NSDictionary *promotionTextAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
//    CGFloat promotionTextH = [recItem.promotionText boundingRectWithSize:CGSizeMake(SCREEN_WIDTH*0.72, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:promotionTextAtt context:nil].size.height;
//    promotionTextH = promotionTextH>40?40:0;
    
    label.text = recItem.promotionText;
    [label sizeToFit];
    height += label.frame.size.height;
    //height += promotionTextH;
    
    height+=10;
    recFloor.rowHeight = height;
    
    HomeItemContentItem *content = [[HomeItemContentItem alloc] init];
    content.imageUrl = recItem.imgUrl;
    content.title = recItem.serveName;
    content.type = HomeItemContentItemTypeRecommend;
    content.price = recItem.price;
    content.recType = recItem.reProductType ;
    content.subTitle = recItem.promotionText;
    
    content.contentSegue = recItem.segueModel;
    recFloor.contents = @[content];
    
    return recFloor;
}


@end
