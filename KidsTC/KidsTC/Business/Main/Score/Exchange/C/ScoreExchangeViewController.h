//
//  ScoreExchangeViewController.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ScoreUserInfoData.h"
@class ScoreExchangeViewController;
@protocol ScoreExchangeViewControllerDelegate <NSObject>
- (void)scoreExchangeViewControllerDidExchangeSuccess:(ScoreExchangeViewController *)controller;
@end

@interface ScoreExchangeViewController : ViewController
@property (nonatomic,strong) ScoreUserInfoData *userInfoData;
@property (nonatomic,  weak) id<ScoreExchangeViewControllerDelegate> delegate;
@end
