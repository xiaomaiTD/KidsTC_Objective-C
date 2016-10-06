//
//  ArticleWeChatModel.h
//  KidsTC
//
//  Created by zhanping on 7/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleWeChatItem : NSObject
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *linkUrl;
@end

@interface ArticleWeChatDataItem : NSObject
@property (nonatomic, strong) NSArray<ArticleWeChatItem *> *item;
@property (nonatomic, strong) NSString *lastTime;
@end

@interface ArticleWeChatModel : NSObject
@property (nonatomic, strong) NSArray<ArticleWeChatDataItem *> *data;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger errNo;
@end
