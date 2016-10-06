//
//  ArticleUserCenterArticleModel.h
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ArticleHomeItem;

@interface ArticleUserCenterArticleModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<ArticleHomeItem *> *data;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger page;
@end
