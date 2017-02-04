//
//  NormalProductDetialCommentItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalProductDetailCommentScore.h"
@interface NormalProductDetialCommentItem : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userImgUrl;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *imageUrl;
@property (nonatomic, assign) NSUInteger replyCount;
@property (nonatomic, assign) NSUInteger praiseCount;
@property (nonatomic, assign) BOOL isPraise;
@property (nonatomic, strong) NormalProductDetailCommentScore *score;
//selfDefine
@property (nonatomic, strong) NSAttributedString *attContent;
@end
