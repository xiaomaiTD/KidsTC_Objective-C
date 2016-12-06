//
//  SearchSectionItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchRowItem.h"

@interface SearchSectionItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<SearchRowItem *> *rows;
+(instancetype)sectionItemWithTitle:(NSString *)title rows:(NSArray<SearchRowItem *> *)rows;
@end
