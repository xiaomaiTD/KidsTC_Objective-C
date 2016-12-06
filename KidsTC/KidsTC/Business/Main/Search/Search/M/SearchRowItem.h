//
//  SearchRowItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchHotKeywordsItem.h"

typedef enum : NSUInteger {
    SearchRowItemTypeHotKey = 1,
    SearchRowItemTypeLocal,
} SearchRowItemType;

@interface SearchRowItem : NSObject
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) SearchRowItemType type;
@property (nonatomic, strong) NSArray<SearchHotKeywordsItem *> *items;
+ (instancetype)rowItemWithType:(SearchRowItemType)type icon:(NSString *)icon items:(NSArray<SearchHotKeywordsItem *> *)items;
@end
