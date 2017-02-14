//
//  ScoreRecordView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreRecordItem.h"

typedef enum : NSUInteger {
    ScoreRecordViewActionTypeLoadData = 1,
} ScoreRecordViewActionType;
@class ScoreRecordView;
@protocol ScoreRecordViewDelegate <NSObject>
- (void)scoreRecordView:(ScoreRecordView *)view actionType:(ScoreRecordViewActionType)type value:(id)value;
@end

@interface ScoreRecordView : UIView
@property (nonatomic,  weak) id<ScoreRecordViewDelegate> delegate;
@property (nonatomic,strong) NSArray<ScoreRecordItem *> *records;
- (void)dealWithUI:(NSUInteger)loadCount;
@end
