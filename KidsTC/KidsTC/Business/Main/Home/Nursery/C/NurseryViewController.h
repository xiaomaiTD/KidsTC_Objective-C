//
//  NurseryViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"

typedef enum : NSUInteger {
    NurseryTypeNursery = 1,
    NurseryTypeExhibitionHall,
} NurseryType;

@interface NurseryViewController : ViewController
@property (nonatomic, assign) NurseryType type;
@end
