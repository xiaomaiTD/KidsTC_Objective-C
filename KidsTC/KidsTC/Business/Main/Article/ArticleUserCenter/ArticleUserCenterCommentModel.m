//
//  ArticleUserCenterCommentModel.m
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleUserCenterCommentModel.h"
#import "NSAttributedString+YYText.h"
#import "NSString+Category.h"

@implementation ArticleUserCenterCommentItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"imgUrls":[NSArray<NSString *> class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    if ([_content isNotNull]) {
        NSMutableAttributedString *contentAttStr = [[NSMutableAttributedString alloc] initWithString:_content];
        contentAttStr.lineSpacing = 4;
        _contentAttStr = contentAttStr;
    }
    return YES;
}
@end

@implementation ArticleUserCenterCommentHeader

@end

@implementation ArticleUserCenterCommentData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"comments":@"ArticleUserCenterCommentItem"};
}
@end

@implementation ArticleUserCenterCommentModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}


@end
