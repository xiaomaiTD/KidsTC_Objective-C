//
//  ScoreUserInfoData.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ScoreUserInfoData : NSObject
@property (nonatomic,strong) NSString *headImg;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *socreRuleUrl;
@property (nonatomic,strong) NSString *radishShopUrl;
@property (nonatomic,strong) NSString *gatherSocreTips;
@property (nonatomic,assign) CGFloat radishExchangeRate;
@property (nonatomic,assign) NSInteger canMaxScore;
@property (nonatomic,assign) NSInteger socreNum;
@property (nonatomic,assign) NSInteger userRadishNum;
@end
