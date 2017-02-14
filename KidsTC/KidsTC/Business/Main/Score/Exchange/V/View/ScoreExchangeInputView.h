//
//  ScoreExchangeInputView.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreUserInfoData.h"

@class ScoreExchangeInputView;
@protocol ScoreExchangeInputViewDelegate <NSObject>
- (void)scoreExchangeInputView:(ScoreExchangeInputView *)view exchangeRadishNum:(NSInteger)radishNum scoreNum:(NSInteger)scoreNum;
@end

@interface ScoreExchangeInputView : UIView
@property (nonatomic,strong) ScoreUserInfoData *userInfoData;
@property (nonatomic,  weak) id<ScoreExchangeInputViewDelegate> delegate;
- (void)startInput:(BOOL)start;
@end
