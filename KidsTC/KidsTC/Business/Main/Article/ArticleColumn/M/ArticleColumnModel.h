//
//  ArticleColumnModel.h
//  KidsTC
//
//  Created by zhanping on 9/2/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleHomeModel.h"

/**SelfDefine*/
@interface ArticleColumnInfo : NSObject
@property (nonatomic, assign) CGFloat bannerPicRatio;
@property (nonatomic, strong) NSString *bannerImg;
@property (nonatomic, strong) NSString *columnName;
@property (nonatomic, strong) NSString *columnSysNo;
@property (nonatomic, assign) BOOL isLiked;
@property (nonatomic, assign) NSUInteger count;
@end

@interface ArticleColumnData : NSObject
@property (nonatomic, strong) NSArray<ArticleHomeItem *> *articleLst;
@property (nonatomic, assign) CGFloat bannerPicRatio;
@property (nonatomic, strong) NSString *bannerImg;
@property (nonatomic, strong) NSString *columnName;
@property (nonatomic, strong) NSString *columnSysNo;
@property (nonatomic, assign) BOOL isLiked;
@property (nonatomic, assign) NSUInteger count;
/**SelfDefine*/
@property (nonatomic, strong) ArticleColumnInfo *info;
@property (nonatomic, strong) NSArray<NSArray<ArticleHomeItem *> *> *sections;
@end

@interface ArticleColumnModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ArticleColumnData *data;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger page;
@end
