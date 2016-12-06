//
//  SearchSectionItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchSectionItem.h"

@implementation SearchSectionItem
+(instancetype)sectionItemWithTitle:(NSString *)title rows:(NSArray<SearchRowItem *> *)rows {
    SearchSectionItem *sectionItem = [SearchSectionItem new];
    sectionItem.title = title;
    sectionItem.rows = rows;
    return sectionItem;
}
@end
