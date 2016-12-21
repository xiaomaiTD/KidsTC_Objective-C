//
//  RecommendProductModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecommendProduct.h"
@interface RecommendProductModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<RecommendProduct *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end
