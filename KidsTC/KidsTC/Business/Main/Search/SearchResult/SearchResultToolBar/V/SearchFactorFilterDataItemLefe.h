//
//  SearchFactorFilterDataItemLefe.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchFactorFilterDataItemRight.h"

@interface SearchFactorFilterDataItemLefe : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL cellSeleted;
@property (nonatomic, strong) NSArray<SearchFactorFilterDataItemRight *> *items;
+ (instancetype)itemWithTitle:(NSString *)title items:(NSArray<SearchFactorFilterDataItemRight *> *)items;
@end
