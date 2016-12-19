//
//  SearchFactorSortDataItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchFactorSortDataItem : NSObject
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) BOOL selected;
+ (instancetype)itemWithImg:(NSString *)img title:(NSString *)title desc:(NSString *)desc value:(NSString *)value;
@end
