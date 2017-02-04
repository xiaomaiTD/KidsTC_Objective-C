//
//  FlashBuyProductDetailCommentListItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashBuyProductDetailScore.h"

@interface FlashBuyProductDetailCommentListItem : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *imageUrl;
@property (nonatomic, assign) BOOL isPraise;
@property (nonatomic, assign) NSInteger praiseCount;
@property (nonatomic, assign) NSInteger replyCount;
@property (nonatomic, strong) NSString *userImgUrl;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *replyUser;
@property (nonatomic, strong) NSString *supplierReplyContent;
@property (nonatomic, strong) FlashBuyProductDetailScore *score;
//selfDefine
@property (nonatomic, strong) NSAttributedString *attContent;
@end
