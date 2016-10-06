//
//  SearchResultFactorShowModel.h
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SearchResultFactorTopItemTypeArea=1,//地区
    SearchResultFactorTopItemTypeSort,//排序
    SearchResultFactorTopItemTypeFilter//筛选
} SearchResultFactorTopItemType;

@interface SearchResultFactorItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign, getter=isSelected) BOOL selected;//将展示交个selected
@property (nonatomic, assign, getter=isMakeSureSelected) BOOL makeSureSelected;//确认选中，将刷新数据交给makeSureSelected
@property (nonatomic, strong) NSArray<NSArray<SearchResultFactorItem *> *> *subArrays;
+(SearchResultFactorItem *)itemWithTitle:(NSString *)title value:(NSString *)value;
+(SearchResultFactorItem *)itemWithTitle:(NSString *)title subArrays:(NSArray<NSArray<SearchResultFactorItem *> *> *)subArrays;

+ (SearchResultFactorItem *)firstSelectedSubItem:(SearchResultFactorItem *)item;
+ (NSIndexPath *)firstSelectedSubItemIndexPath:(SearchResultFactorItem *)item;
@end

@interface SearchResultFactorTopItem : SearchResultFactorItem
@property (nonatomic, assign) SearchResultFactorTopItemType type;
@end

@interface SearchResultFactorShowModel : NSObject
@property (nonatomic, strong) NSArray<SearchResultFactorTopItem *> *items;
+(instancetype)modelWithShowItems:(NSArray<SearchResultFactorTopItem *> *)items;
@end
