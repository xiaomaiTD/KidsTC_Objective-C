//
//  ScoreConsumeView.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreUserInfoData.h"
#import "ScoreConsumeTopicItem.h"
#import "ScoreConsumeProductData.h"

typedef enum : NSUInteger {
    ScoreConsumeViewActionTypeLoadData = 1,
    ScoreConsumeViewActionTypeSegue = 50,
} ScoreConsumeViewActionType;

@class ScoreConsumeView;
@protocol ScoreConsumeViewDelegate <NSObject>
- (void)scoreConsumeView:(ScoreConsumeView *)view actionType:(ScoreConsumeViewActionType)type value:(id)value;
@end

@interface ScoreConsumeView : UIView
@property (nonatomic,strong) ScoreUserInfoData *userInfoData;
@property (nonatomic,strong) NSArray<ScoreConsumeTopicItem *> *topicItems;
@property (nonatomic,strong) ScoreConsumeProductData *productData;
@property (nonatomic,  weak) id<ScoreConsumeViewDelegate> delegate;
- (void)dealWithUI:(NSUInteger)loadCount;
- (void)reloadData;
@end
