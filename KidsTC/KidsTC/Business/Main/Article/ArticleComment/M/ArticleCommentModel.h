//
//  ArticleCommentModel.h
//  KidsTC
//
//  Created by zhanping on 4/26/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADArticleInfro : NSObject
@property (nonatomic, strong) NSString *articleSysNo;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *briefConent;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, assign) NSUInteger shareCount;
@end

@interface ACReply : NSObject
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *content;
@end

@interface EvaListItem : NSObject
@property (nonatomic, strong) NSString *articleSysNo;
@property (nonatomic, strong) NSString *articleTitle;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) ACReply *reply;
@property (nonatomic, strong) NSString *commentSysNo;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userHeadImg;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *imgUrls;
@property (nonatomic, assign) BOOL isReplyed;
@property (nonatomic, assign) BOOL isPraised;
@property (nonatomic, assign) NSInteger praiseCount;
@property (nonatomic, assign) NSInteger linkType;
@property (nonatomic, strong) NSDictionary *params;
@end

@interface ADMyEva : NSObject
@property (nonatomic, assign) NSUInteger evaCount;
@property (nonatomic, strong) NSArray *evaList;
@end

@interface ADHotEva : NSObject
@property (nonatomic, assign) NSUInteger evaCount;
@property (nonatomic, strong) NSArray *evaList;
@end

@interface ACData : NSObject
@property (nonatomic, strong) ADArticleInfro *articleInfo;
@property (nonatomic, strong) ADMyEva *myEva;
@property (nonatomic, strong) ADHotEva *hotEva;
@property (nonatomic, strong) NSArray *comments;
@end

@interface ArticleCommentResponseModel : NSObject
@property (nonatomic, strong) ACData *data;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSString *page;
@end



@interface ArticleCommentNeedModel : NSObject
@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, assign) BOOL hasMore;
@end




@interface UDHeader : NSObject
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *headUrl;
@end

@interface UAData: NSObject
@property (nonatomic, strong) UDHeader *header;
@property (nonatomic, strong) NSArray *comments;
@end

@interface UserArticleCommentsResponseModel : NSObject
@property (nonatomic, strong) UAData *data;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSString *page;
@end


@interface MessageCenterResponseModel : NSObject
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;

@end



























