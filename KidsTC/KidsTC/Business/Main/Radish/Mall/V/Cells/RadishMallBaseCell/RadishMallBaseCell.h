//
//  RadishMallBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishMallData.h"

typedef enum : NSUInteger {
    RadishMallBaseCellActionTypeSegue = 1,
    RadishMallBaseCellActionTypePlant,
    RadishMallBaseCellActionTypeRule,
} RadishMallBaseCellActionType;

@class RadishMallBaseCell;
@protocol RadishMallBaseCellDelegate <NSObject>
- (void)radishMallBaseCell:(RadishMallBaseCell *)cell actionType:(RadishMallBaseCellActionType)type value:(id)value;
@end

@interface RadishMallBaseCell : UITableViewCell
@property (nonatomic, weak) id<RadishMallBaseCellDelegate> delegate;
@property (nonatomic, strong) RadishMallData *data;
@property (nonatomic, strong) RadishMallProduct *product;
@end
