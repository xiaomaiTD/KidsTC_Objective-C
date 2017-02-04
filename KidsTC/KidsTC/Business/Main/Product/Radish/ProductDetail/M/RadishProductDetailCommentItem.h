//
//  ProduceDetialCommentItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailCommentScore.h"

@interface RadishProductDetailCommentItem : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userImgUrl;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *imageUrl;
@property (nonatomic, assign) NSUInteger replyCount;
@property (nonatomic, assign) NSUInteger praiseCount;
@property (nonatomic, assign) BOOL isPraise;
@property (nonatomic, strong) RadishProductDetailCommentScore *score;
//selfDefine
@property (nonatomic, strong) NSAttributedString *attContent;
@end
