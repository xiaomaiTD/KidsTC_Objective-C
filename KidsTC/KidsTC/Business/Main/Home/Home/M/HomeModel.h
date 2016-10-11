//
//  HomeModel.h
//  KidsTC
//
//  Created by ling on 16/7/19.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
#import "Model.h"


@interface TextSegueModel : NSObject

@property (nonatomic, copy, readonly) NSString *linkWords;
@property (nonatomic, strong, readonly) SegueModel *segueModel;
@property (nonatomic, copy, readonly) NSString *promotionWords;
@property (nonatomic, readonly) NSRange linkRange;
@property (nonatomic, readonly) NSArray<NSString *> *linkRangeStrings;
@property (nonatomic, strong) UIColor *linkColor;

- (instancetype)initWithLinkParam:(NSDictionary *)param promotionWords:(NSString *)words;

@end


@interface HomeNewRecItem : NSObject

@property (nonatomic, assign) NSInteger serveId;
@property (nonatomic, assign) NSInteger channelId;
@property (nonatomic, assign) NSInteger reProductType;
@property (nonatomic, copy) NSString *serveName;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *promotionText;
@property (nonatomic, strong) NSString *picRate;
//@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) SegueModel *segueModel;
@end

@interface HomeRecommendModel : NSObject

@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray <HomeNewRecItem *>*data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *page;

@end


@interface HomeItemArticleParamItem : NSObject

@property (nonatomic, assign) NSInteger viewTimes;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) BOOL isHot;
@property (nonatomic, assign) BOOL isRecommend;

@end


@interface HomeItemParamItem : NSObject

@property (nonatomic, copy) NSString *linkurl;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *k;
@property (nonatomic, copy) NSString *st;
@property (nonatomic, copy) NSString *c;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, copy) NSString *a;
@property (nonatomic, copy) NSString *ak;
@property (nonatomic, copy) NSString *p;
@property (nonatomic, copy) NSString *t;

@end



@interface HomeItemTitleItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *linkType;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, copy) NSString *subName;
@property (nonatomic, copy) NSString *remainTime;
@property (nonatomic, copy) NSString *remainName;
@property (nonatomic, strong) SegueModel *titleSegue;
@end


typedef enum : NSUInteger {
    HomeItemContentItemTypeNormal=1,
    HomeItemContentItemTypeRecommend,
} HomeItemContentItemType;

@interface HomeItemContentItem : NSObject //内容模型

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) NSInteger linkType;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) HomeItemArticleParamItem *articleParam;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *linkKey;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, assign) NSInteger recType;
//@property (nonatomic, assign) NSInteger sale;
@property (nonatomic, strong) SegueModel *contentSegue;
@property (nonatomic, assign) HomeItemContentItemType type;
@end


typedef enum {
    HomeTitleCellTypeNormalTitle = 1,
    HomeTitleCellTypeMoreTitle,
    HomeTitleCellTypeCountDownTitle,
    HomeTitleCellTypeCountDownMoreTitle
}HomeTitleCellType;
typedef enum {
    HomeContentCellTypeBanner = 1,
    HomeContentCellTypeTwinklingElf = 2,
    HomeContentCellTypeHorizontalList = 3,
    HomeContentCellTypeThree = 4,
    HomeContentCellTypeTwoColumn = 5,
    HomeContentCellTypeNews = 6,
    HomeContentCellTypeImageNews = 7,
    HomeContentCellTypeThreeImageNews = 8,
    HomeContentCellTypeWholeImageNews = 11,
    HomeContentCellTypeNotice = 12,
    HomeContentCellTypeBigImageTwoDesc = 13,
    HomeContentCellTypeTwoThreeFour = 14,
    HomeContentCellTypeRecommend = 15
}HomeContentCellType;

@interface HomeFloorsItem : NSObject

@property (nonatomic, copy) NSString *bgImgUrl;
@property (nonatomic, strong) NSArray<HomeItemContentItem *> *contents;
@property (nonatomic, strong) HomeItemTitleItem *titleContent;
@property (nonatomic, assign) HomeContentCellType contentType;
@property (nonatomic, assign) BOOL hasTitle;
@property (nonatomic, strong) NSNumber *ratio;
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) HomeTitleCellType titleType;
@property (nonatomic, assign) NSInteger centerSeparation;
@property (nonatomic, assign) NSInteger bottomSeparation;
@property (nonatomic, assign) CGFloat titleHeight;//标题行高
@property (nonatomic, assign) CGFloat rowHeight;//自定义属性 通过 ratio 返回cell行高
@property (nonatomic, assign) NSInteger floorIndex;
@end

typedef enum {
    HomeFloorTypeDefault,
    HomeFloorTypeHasNavi
}HomeFloorType;
@interface HomeDataItem : NSObject

@property (nonatomic, assign) HomeFloorType floorType;
@property (nonatomic, strong) NSString *floorName;
@property (nonatomic, strong) NSArray<HomeFloorsItem *> *floors;//主页数据
@property (nonatomic, assign) NSInteger dataIndex;
@end


@interface HomeModel : NSObject

@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<HomeDataItem *> *data;
@property (nonatomic, strong) NSString *md5;
@property (nonatomic, strong) NSArray <HomeDataItem *>*naviDatas;
@property (nonatomic, strong) NSArray <HomeFloorsItem *>* allFloors;//包括楼层导航在内的所有数据(不含为您推荐)
@end
