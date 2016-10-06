//
//  ArticleUserCenterCommentModel.h
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SegueModel.h"

@interface ArticleUserCenterCommentItem : NSObject
@property (nonatomic, strong) NSString *articleSysNo;
@property (nonatomic, strong) NSString *articleTitle;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *reply;
@property (nonatomic, strong) NSString *commentSysNo;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userHeadImg;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *imgUrls;
@property (nonatomic, assign) BOOL isReplyed;
@property (nonatomic, assign) BOOL isPraised;
@property (nonatomic, assign) NSUInteger praiseCount;
/**SelfDefine*/
@property (nonatomic, strong) SegueModel *segueModel;
@property (nonatomic, strong) NSAttributedString *contentAttStr;
@end

@interface ArticleUserCenterCommentHeader : NSObject
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *headUrl;
@end

@interface ArticleUserCenterCommentData : NSObject
@property (nonatomic, strong) ArticleUserCenterCommentHeader *header;
@property (nonatomic, strong) NSArray<ArticleUserCenterCommentItem *> *comments;
@end

@interface ArticleUserCenterCommentModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ArticleUserCenterCommentData *data;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger page;
@end
