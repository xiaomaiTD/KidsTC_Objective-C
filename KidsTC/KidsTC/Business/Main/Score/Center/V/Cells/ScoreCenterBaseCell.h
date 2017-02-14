//
//  ScoreCenterBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreUserInfoData.h"
typedef enum : NSUInteger {
    ScoreCenterBaseCellActionTypeRule = 1,
    ScoreCenterBaseCellActionTypeGet,
    ScoreCenterBaseCellActionTypeUse,
    ScoreCenterBaseCellActionTypeMore
} ScoreCenterBaseCellActionType;
@class ScoreCenterBaseCell;
@protocol ScoreCenterBaseCellDelegate <NSObject>
- (void)scoreCenterBaseCell:(ScoreCenterBaseCell *)cell actionType:(ScoreCenterBaseCellActionType)type vlaue:(id)value;
@end

@interface ScoreCenterBaseCell : UITableViewCell
@property (nonatomic,  weak) id<ScoreCenterBaseCellDelegate> delegate;
@property (nonatomic,strong) ScoreUserInfoData *userInfoData;
@end
