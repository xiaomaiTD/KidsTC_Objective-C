//
//  NormalProductDetailCommentScore.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalProductDetailScoreItem.h"

@interface NormalProductDetailCommentScore : NSObject
@property (nonatomic, assign) CGFloat OverallScore;
@property (nonatomic, strong) NSArray<NormalProductDetailScoreItem *> *ScoreDetail;
@end
