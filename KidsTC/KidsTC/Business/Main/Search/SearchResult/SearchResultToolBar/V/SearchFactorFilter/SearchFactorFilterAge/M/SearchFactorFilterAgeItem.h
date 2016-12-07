//
//  SearchFactorFilterAgeItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchFactorFilterAgeItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) BOOL dataSelected;
@property (nonatomic, assign) BOOL cellSelected;
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value;
+ (NSArray<SearchFactorFilterAgeItem *> *)items;
@end
