//
//  ScoreCenterView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreUserInfoData.h"
#import "ScoreRecordItem.h"

typedef enum : NSUInteger {
    ScoreCenterViewActionTypeRule = 1,
    ScoreCenterViewActionTypeGet,
    ScoreCenterViewActionTypeUse,
    ScoreCenterViewActionTypeMore
} ScoreCenterViewActionType;

@class ScoreCenterView;
@protocol ScoreCenterViewDelegate <NSObject>
- (void)scoreCenterView:(ScoreCenterView *)view actionType:(ScoreCenterViewActionType)type vlaue:(id)value;
@end

@interface ScoreCenterView : UIView
@property (nonatomic,strong) NSArray<ScoreRecordItem *> *records;
@property (nonatomic,strong) ScoreUserInfoData *userInfoData;
@property (nonatomic,  weak) id<ScoreCenterViewDelegate> delegate;
@end
