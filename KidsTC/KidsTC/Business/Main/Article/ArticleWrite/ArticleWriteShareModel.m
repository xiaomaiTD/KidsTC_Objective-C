//
//  ArticleWriteShareModel.m
//  KidsTC
//
//  Created by zhanping on 2016/9/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleWriteShareModel.h"

@implementation ArticleWriteShareData

@end

@implementation ArticleWriteShareModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
