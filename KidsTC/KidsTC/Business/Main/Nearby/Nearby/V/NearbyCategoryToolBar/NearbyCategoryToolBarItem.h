//
//  NearbyCategoryToolBarItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyCategoryToolBarItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) BOOL selected;
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value;
+ (NSArray<NearbyCategoryToolBarItem *> *)items;
@end
