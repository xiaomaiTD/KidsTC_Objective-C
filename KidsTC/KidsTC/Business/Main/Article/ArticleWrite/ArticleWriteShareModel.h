//
//  ArticleWriteShareModel.h
//  KidsTC
//
//  Created by zhanping on 2016/9/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleWriteShareData : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *imgUrl;
@end

@interface ArticleWriteShareModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ArticleWriteShareData *data;
@end
