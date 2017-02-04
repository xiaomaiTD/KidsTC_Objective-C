//
//  NormalProductDetailInsuranceItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NormalProductDetailInsuranceItem : NSObject
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
+ (instancetype)item:(NSString *)imageName title:(NSString *)title;
@end
