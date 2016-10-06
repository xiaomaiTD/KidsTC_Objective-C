//
//  ArticleHomeUserInfoModel.h
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleHomeUserInfoData : NSObject
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *headUrl;
@end

@interface ArticleHomeUserInfoModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ArticleHomeUserInfoData *data;
@end
