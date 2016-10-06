//
//  ArticleColumnModel.m
//  KidsTC
//
//  Created by zhanping on 9/2/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleColumnModel.h"

@implementation ArticleColumnInfo

@end

@implementation ArticleColumnData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"articleLst":[ArticleHomeItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupInfo];
    
    [self setupSections];
    
    return YES;
}
- (void)setupInfo {
    _info = [[ArticleColumnInfo alloc] init];
    _info.bannerPicRatio = _bannerPicRatio>0?_bannerPicRatio:0.6;
    _info.bannerImg = _bannerImg;
    _info.columnName = _columnName;
    _info.columnSysNo = _columnSysNo;
    _info.isLiked = _isLiked;
    _info.count = _count;
}

- (void)setupSections {
    
    NSMutableArray<NSMutableArray<ArticleHomeItem *> *> *sections = [NSMutableArray array];
    [_articleLst enumerateObjectsUsingBlock:^(ArticleHomeItem *obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray<ArticleHomeItem *> *section_item = [NSMutableArray array];
        [section_item addObject:obj];
        [sections addObject:section_item];
    }];
    _sections = sections.count>0?[NSArray arrayWithArray:sections]:nil;
}

@end

@implementation ArticleColumnModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
