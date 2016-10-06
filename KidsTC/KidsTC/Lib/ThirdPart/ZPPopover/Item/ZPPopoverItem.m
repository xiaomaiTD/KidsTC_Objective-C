//
//  ZpMenuItem.m
//  ZpMenuController
//
//  Created by zhanping on 3/16/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ZPPopoverItem.h"

@implementation ZPPopoverItem


+(ZPPopoverItem *)makeZpMenuItemWithImageName:(NSString *)imageName title:(NSString *)title{
    
    return [[ZPPopoverItem alloc]initWithImageName:imageName title:title];
}

-(instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title{
    self = [super init];
    if (self) {
        _imageName = imageName;
        _title = title;
    }
    return self;
}
@end
