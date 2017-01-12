//
//  SeckillToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillDataData.h"
#import "SeckillTimeData.h"
extern CGFloat const kSeckillToolBarH;

@class SeckillToolBar;
@protocol SeckillToolBarDelegate <NSObject>
- (void)seckillToolBar:(SeckillToolBar *)toolBar actionType:(SeckillTimeToolBarItemActionType)type value:(id)value;
@end

@interface SeckillToolBar : UIView
@property (nonatomic, strong) SeckillDataData *dataData;
@property (nonatomic, strong) SeckillTimeData *timeData;
@property (nonatomic, weak) id<SeckillToolBarDelegate> delegate;
@end
