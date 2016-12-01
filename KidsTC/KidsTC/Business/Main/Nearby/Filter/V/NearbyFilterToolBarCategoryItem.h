//
//  NearbyFilterToolBarCategoryItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearbyFilterToolBarCategoryItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) BOOL selected;
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value;
+ (NSArray<NearbyFilterToolBarCategoryItem *> *)items;
@end
