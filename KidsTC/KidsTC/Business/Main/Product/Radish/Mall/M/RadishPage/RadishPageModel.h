//
//  RadishPageModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadishMallProduct.h"
@interface RadishPageModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<RadishMallProduct *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end
