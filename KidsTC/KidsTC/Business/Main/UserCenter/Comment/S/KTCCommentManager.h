//
//  KTCCommentManager.h
//  KidsTC
//
//  Created by 钱烨 on 8/21/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    KTCCommentTypeNone,
    KTCCommentTypeAll,
    KTCCommentTypeGood,
    KTCCommentTypeNormal,
    KTCCommentTypeBad,
    KTCCommentTypePicture
}KTCCommentType;

typedef enum {
    CommentRelationTypeNone = 0,
    CommentRelationTypeServiceProduct = 1,
    CommentRelationTypeActivityProduct = 2,
    CommentRelationTypeRealProduct = 3,
    CommentRelationTypeStore = 10,
    CommentRelationTypeStrategy = 11,
    CommentRelationTypeStrategyDetail = 12,
    CommentRelationTypeNews = 13,
    CommentRelationTypeTicketProduct = 14,//票务服务
    CommentRelationTypeFreeProductService = 15,//免费服务
    CommentRelationTypeFreeProductActivity = 16,//免费服务-活动
    CommentRelationTypeFreeProductMaterialObject = 17,//免费服务-实物
}CommentRelationType;

typedef enum {
    CommentFoundingSourceTypeService = 1,
    CommentFoundingSourceTypeActivity = 2,
    CommentFoundingSourceTypeProduct = 3,
    CommentFoundingSourceTypeStore = 10,
    CommentFoundingSourceTypeStrategy = 11,
    CommentFoundingSourceTypeStrategyDetail = 12,
    CommentFoundingSourceTypeNews = 13,
    CommentFoundingSourceTypeTicketProduct = 14,//票务服务
    CommentFoundingSourceTypeFreeProductService = 15,//免费服务
    CommentFoundingSourceTypeFreeProductActivity = 16,//免费服务-活动
    CommentFoundingSourceTypeFreeProductMaterialObject = 17,//免费服务-实物
}CommentFoundingSourceType;

typedef struct {
    CommentRelationType relationType;
    KTCCommentType commentType;
    NSUInteger pageIndex;
    NSUInteger pageSize;
}KTCCommentRequestParam;

@class KTCCommentObject;


@interface KTCCommentManager : NSObject
//config
- (void)getScoreConfigWithSourceType:(CommentFoundingSourceType)type succeed:(void(^)(NSDictionary *data))succeed failure:(void(^)(NSError *error))failure;

//add
- (void)addCommentWithObject:(KTCCommentObject *)object succeed:(void(^)(NSDictionary *data))succeed failure:(void(^)(NSError *error))failure;

//load
- (void)loadCommentsWithIdentifier:(NSString *)identifier RequestParam:(KTCCommentRequestParam)param succeed:(void(^)(NSDictionary *data))succeed failure:(void(^)(NSError *error))failure;

//load user
- (void)loadUserCommentsWithPageIndex:(NSUInteger)index pageSize:(NSUInteger)size succeed:(void(^)(NSDictionary *data))succeed failure:(void(^)(NSError *error))failure;

//delete user
- (void)deleteUserCommentWithRelationIdentifier:(NSString *)rId
                              commentIdentifier:(NSString *)cId
                                   relationType:(CommentRelationType)type
                                        succeed:(void(^)(NSDictionary *data))succeed
                                        failure:(void(^)(NSError *error))failure;

//modify user
- (void)modifyUserCommentWithObject:(KTCCommentObject *)object succeed:(void(^)(NSDictionary *data))succeed failure:(void(^)(NSError *error))failure;

@end


@interface KTCCommentObject : NSObject

//当前评论关联编号，必传
@property (nonatomic, copy) NSString *identifier;

//当前评论关联类型，必传
@property (nonatomic, assign) CommentRelationType relationType;

//是否匿名，必传
@property (nonatomic, assign) BOOL isAnonymous;

//是否评论（否：回复），必传
@property (nonatomic, assign) BOOL isComment;

//当前回复的评论编号
@property (nonatomic, copy) NSString *commentIdentifier;

//评论内容，必传
@property (nonatomic, copy) NSString *content;

//当前上传的图片链接
@property (nonatomic, strong) NSArray<NSString *> *uploadImageStrings;

//订单号，当relationType为product时必传
@property (nonatomic, copy) NSString *orderId;

//总体评分，当relationType为product时必传
@property (nonatomic, assign) NSUInteger totalScore;

//详细评分，当relationType为product时必传
@property (nonatomic, strong) NSDictionary *scoresDetail;

- (NSString *)uploadImagesCombinedString;

- (NSString *)scoreCombinedString;

- (NSDictionary *)addCommentRequestParam;

@end
