//
//  SeckillTimeToolBarItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SeckillTimeToolBarItemActionTypeHome = 300,//首页
    SeckillTimeToolBarItemActionTypePocket,//我的购物袋
    SeckillTimeToolBarItemActionTypeOther,//其他优惠活动
} SeckillTimeToolBarItemActionType;

@interface SeckillTimeToolBarItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) SeckillTimeToolBarItemActionType type;
+ (instancetype)itemWithTitle:(NSString *)title img:(NSString *)img type:(SeckillTimeToolBarItemActionType)type;
@end
