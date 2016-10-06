//
//  StrategyModel.h
//  KidsTC
//
//  Created by zhanping on 6/3/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//





#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface StrategyListItem : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *simply;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *authorImgUrl;
@property (nonatomic, assign) NSInteger viewCount;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger praiseCount;
@property (nonatomic, assign) BOOL isInterest;
@property (nonatomic, assign) NSInteger interestCount;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) BOOL isRecommend;
@property (nonatomic, assign) BOOL isHot;
@property (nonatomic, assign) BOOL isNew;
@end

@interface StrategyTypeListTagItem : NSObject
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *name;
@end
@interface StrategyTypeListBannerItem : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) NSInteger linkType;
@property (nonatomic, strong) NSDictionary *params;
@end
@interface StrategyTypeListTagPicItem : NSObject
@property (nonatomic, assign) NSInteger tagId;
@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, strong) NSString *imgUrl;
@end

@interface StrategyTypeList : NSObject
@property (nonatomic, strong) NSArray<StrategyTypeListTagItem *> *tag;
@property (nonatomic, strong) NSArray<StrategyTypeListBannerItem *> *banner;
@property (nonatomic, strong) NSArray<StrategyTypeListTagPicItem *> *tagPic;
@end

@interface StrategyData : NSObject
@property (nonatomic, strong) NSArray<StrategyListItem *> *list;
@property (nonatomic, strong) StrategyTypeList *typeList;
@end

@interface StrategyModel : NSObject
@property (nonatomic, strong) StrategyData *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end



/**
 *  用于数据展示用的Header
 */
@interface StrategyShowHeader : NSObject
@property (nonatomic, strong) NSArray<StrategyTypeListBannerItem *> *banner;
@property (nonatomic, strong) NSArray<StrategyTypeListTagPicItem *> *tagPic;
+(instancetype)headerWithBanner:(NSArray<StrategyTypeListBannerItem *> *)banner tagPic:(NSArray<StrategyTypeListTagPicItem *> *)tagPic;
@end


/**
 *  用于数据展示用的Model
 */
@interface StrategyShowModel : NSObject
@property (nonatomic, assign) NSInteger currentTagId;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) NSArray<StrategyListItem *> *list;
@property (nonatomic, strong) StrategyShowHeader *header;
+(instancetype)modelWithCurrentTagId:(NSInteger)currentTagId currentIndex:(NSUInteger)currentIndex;
@end





















