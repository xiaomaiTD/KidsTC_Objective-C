//
//  ScoreConsumeProductModel.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/14.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreConsumeProductData.h"
@interface ScoreConsumeProductModel : NSObject
@property (nonatomic,assign) NSInteger errNo;
@property (nonatomic,strong) ScoreConsumeProductData *data;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSString *page;
@end
