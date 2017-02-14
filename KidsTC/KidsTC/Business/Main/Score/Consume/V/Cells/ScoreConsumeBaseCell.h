//
//  ScoreConsumeBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreConsumeShowItem.h"

typedef enum : NSUInteger {
    ScoreConsumeBaseCellActionTypeSegue = 50,
} ScoreConsumeBaseCellActionType;
@class ScoreConsumeBaseCell;
@protocol ScoreConsumeBaseCellDelegate <NSObject>
- (void)scoreConsumeBaseCell:(ScoreConsumeBaseCell *)cell actionType:(ScoreConsumeBaseCellActionType)type value:(id)value;
@end

@interface ScoreConsumeBaseCell : UITableViewCell
@property (nonatomic,strong) ScoreConsumeShowItem *item;
@property (nonatomic,  weak) id<ScoreConsumeBaseCellDelegate> delegate;
@end
