//
//  FlashBuyProductDetailScore.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashBuyProductDetailScoreDetail.h"

@interface FlashBuyProductDetailScore : NSObject
@property (nonatomic, assign) CGFloat OverallScore;
@property (nonatomic, strong) NSArray<FlashBuyProductDetailScoreDetail *> *ScoreDetail;
@end
