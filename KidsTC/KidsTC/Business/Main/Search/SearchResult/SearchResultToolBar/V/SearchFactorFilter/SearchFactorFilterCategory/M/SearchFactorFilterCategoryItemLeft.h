//
//  SearchFactorFilterCategoryItemLeft.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchFactorFilterCategoryItemRight.h"

@interface SearchFactorFilterCategoryItemLeft : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) BOOL dataSelected;
@property (nonatomic, assign) BOOL cellSelected;
@property (nonatomic, assign) BOOL currentCell;
@property (nonatomic, strong) NSArray<SearchFactorFilterCategoryItemRight *> *rightItems;
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon rightItems:(NSArray<SearchFactorFilterCategoryItemRight *> *)rightItems;
+ (NSArray<SearchFactorFilterCategoryItemLeft *> *)leftItems;
@end
