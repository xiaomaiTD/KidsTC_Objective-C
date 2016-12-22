//
//  RecommendTarento.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleHomeModel.h"

@interface RecommendTarento : NSObject
@property (nonatomic, assign) BOOL isCollected;
@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSString *authorUid;
@property (nonatomic, strong) NSString *authorNo;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *authorSign;
@property (nonatomic, strong) NSString *authorDesc;
@property (nonatomic, strong) NSString *headSculpture;
@property (nonatomic, strong) NSString *publishArticleNum;
@property (nonatomic, strong) NSString *viewSumNum;
@property (nonatomic, strong) NSString *newsCount;
@property (nonatomic, strong) NSArray<ArticleHomeItem *> *articleLst;
@property (nonatomic, strong) NSString *collectedTimeDesc;
@end
