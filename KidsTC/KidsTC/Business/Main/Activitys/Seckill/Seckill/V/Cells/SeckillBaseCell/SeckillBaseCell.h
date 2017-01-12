//
//  SeckillBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillDataItem.h"

typedef enum : NSUInteger {
    SeckillBaseCellActionTypeSegue = 1,//通用跳转
    SeckillBaseCellActionTypeRemind ,//设置提醒
} SeckillBaseCellActionType;

@class SeckillBaseCell;
@protocol SeckillBaseCellDelegate <NSObject>
- (void)seckillBaseCell:(SeckillBaseCell *)cell actionType:(SeckillBaseCellActionType)type value:(id)value;
@end

@interface SeckillBaseCell : UITableViewCell
@property (nonatomic, strong) SeckillDataItem *item;
@property (nonatomic, weak) id<SeckillBaseCellDelegate> delegate;
@end
