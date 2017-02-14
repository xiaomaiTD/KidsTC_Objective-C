//
//  ScoreConsumeProductData.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/14.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreProductItem.h"
@interface ScoreConsumeProductData : NSObject
@property (nonatomic,strong) NSArray<ScoreProductItem *> *products;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSInteger count;
@end
