//
//  ProductDetailFreeApplySelectBirthViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"

@interface ProductDetailFreeApplySelectBirthViewController : ViewController
@property (nonatomic, copy) void(^makeSureBlock)(NSDate *date);
@end
