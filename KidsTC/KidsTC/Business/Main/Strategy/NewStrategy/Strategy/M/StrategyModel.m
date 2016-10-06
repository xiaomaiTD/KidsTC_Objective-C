//
//  StrategyModel.m
//  KidsTC
//
//  Created by zhanping on 6/3/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyModel.h"

@implementation StrategyListItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
@end

@implementation StrategyTypeListTagItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
@end
@implementation StrategyTypeListBannerItem

@end
@implementation StrategyTypeListTagPicItem

@end

@implementation StrategyTypeList
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"tag" : [StrategyTypeListTagItem class],
             @"banner":[StrategyTypeListBannerItem class],
             @"tagPic":[StrategyTypeListTagPicItem class]};
}

@end

@implementation StrategyData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
     return @{@"list" : [StrategyListItem class]};
}
@end

@implementation StrategyModel

@end

@implementation StrategyShowHeader
- (instancetype)initWithBanner:(NSArray<StrategyTypeListBannerItem *> *)banner tagPic:(NSArray<StrategyTypeListTagPicItem *> *)tagPic{
    self = [super init];
    if (self) {
        self.banner = banner;
        self.tagPic = tagPic;
    }
    return self;
}
+(instancetype)headerWithBanner:(NSArray<StrategyTypeListBannerItem *> *)banner tagPic:(NSArray<StrategyTypeListTagPicItem *> *)tagPic{
    return [[self alloc] initWithBanner:banner tagPic:tagPic];
}
@end

@implementation StrategyShowModel
- (instancetype)initWithCurrentTagId:(NSInteger)currentTagId currentIndex:(NSUInteger)currentIndex{
    self = [super init];
    if (self) {
        self.currentTagId = currentTagId;
        self.currentIndex = currentIndex;
        self.currentPage = 1;
    }
    return self;
}
+(instancetype)modelWithCurrentTagId:(NSInteger)currentTagId currentIndex:(NSUInteger)currentIndex{
    return [[StrategyShowModel alloc]initWithCurrentTagId:currentTagId currentIndex:currentIndex];
}
@end
