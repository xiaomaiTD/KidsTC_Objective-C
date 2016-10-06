//
//  ZpMenuItem.h
//  ZpMenuController
//
//  Created by zhanping on 3/16/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPPopoverItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;
/**
 *  生成每个ZpMenuItem实体对象
 *
 *  @param imageName 图片名称
 *  @param title 标题
 *
 *  @return ZpMenuItem实体对象
 */
+(ZPPopoverItem *)makeZpMenuItemWithImageName:(NSString *)imageName title:(NSString *)title;
@end
