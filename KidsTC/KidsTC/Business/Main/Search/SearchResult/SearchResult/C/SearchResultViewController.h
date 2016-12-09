//
//  SearchResultViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"

/*
 k:搜索关键字
 
 s:地理位置
    全部:@""
 
 st:排序规则
    @"智能排序":@"1"
    @"按销量排序":@"8"
    @"按星级排序":@"7"
    @"价格从低到高":@"4"
    @"价格从高到低":@"5"
 
 a:年龄段
    
 c:分类
    
 */

@interface SearchResultViewController : ViewController

- (void)setSearchType:(SearchType)searchType params:(NSDictionary *)params;
@end
