//
//  RadishProductDetailInsuranceItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadishProductDetailInsuranceItem : NSObject
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
+ (instancetype)item:(NSString *)imageName title:(NSString *)title;
@end
