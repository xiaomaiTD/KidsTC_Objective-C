//
//  TCStoreDetailCommentItemScore.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCStoreDetailScoreItem.h"
@interface TCStoreDetailCommentItemScore : NSObject
@property (nonatomic, assign) CGFloat OverallScore;
@property (nonatomic, strong) NSArray<TCStoreDetailCommentItemScore *> *ScoreDetail;
@end
