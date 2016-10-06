//
//  WelfareStoreViewController.h
//  KidsTC
//
//  Created by zhanping on 7/22/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"

typedef enum : NSUInteger {
    WelfareTypeHospital=1,//保健室
    WelfareTypeLoveHouse,//爱心妈咪小屋
} WelfareType;

@interface WelfareStoreViewController : ViewController
@property (nonatomic, assign) WelfareType type;
@end
