//
//  SearchHotKeywordsItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//
#import "Model.h"
#import <Foundation/Foundation.h>

@interface SearchHotKeywordsItem : Model
@property (nonatomic, strong) NSDictionary *search_parms;
@property (nonatomic, strong) NSString *name;
+ (instancetype)itemWithName:(NSString *)name;
@end
