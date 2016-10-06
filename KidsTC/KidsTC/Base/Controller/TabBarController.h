//
//  TabBarController.h
//  KidsTC
//
//  Created by 詹平 on 16/7/15.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHeader.h"
@interface TabBarController : UITabBarController
singleH(TabBarController)

/**
 *  根据脚标Index，选中TabBarController的某一个控制器
 *
 *  @param index 脚标
 */
- (void)selectIndex:(NSUInteger)index;

@end
