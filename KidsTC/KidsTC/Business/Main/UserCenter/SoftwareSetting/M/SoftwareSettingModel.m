//
//  SoftwareSettingModel.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SoftwareSettingModel.h"

@implementation SoftwareSettingModel

-(instancetype)initWithTitle:(NSString *)title
                       subTitle:(NSString *)subTitle
                   showArrow:(BOOL)showArrow
                         sel:(SEL)sel
{
    self = [super init];
    if (self) {
        self.title = title;
        self.subTitle = subTitle;
        self.showArrow = showArrow;
        self.sel =sel;
    }
    return self;
}

+(instancetype)modelWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                    showArrow:(BOOL)showArrow
                          sel:(SEL)sel
{
    return [[self alloc]initWithTitle:title subTitle:subTitle showArrow:showArrow sel:sel];
}
@end
