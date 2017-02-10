//
//  ProductDetailActivity.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

typedef enum : NSUInteger {
    ProductDetailActivityTypeSeckill = 1,//秒杀
    ProductDetailActivityTypeFightGroup,//拼团
} ProductDetailActivityType;

@interface ProductDetailActivity : NSObject
@property (nonatomic, strong) NSString *tip;
@property (nonatomic, assign) ProductDetailActivityType type;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
