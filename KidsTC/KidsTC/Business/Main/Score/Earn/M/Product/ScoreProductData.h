//
//  ScoreProductData.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreProductItem.h"
@interface ScoreProductData : NSObject
@property (nonatomic,strong) NSArray<ScoreProductItem *> *products;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSInteger count;
@end
