//
//  SeckillToolBarItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillTimeToolBarItem.h"

@class SeckillToolBarItem;
@protocol SeckillToolBarItemDelegate <NSObject>
- (void)didClickSeckillToolBarItem:(SeckillToolBarItem *)item;
@end

@interface SeckillToolBarItem : UIView
@property (nonatomic, strong) SeckillTimeToolBarItem *item;
@property (nonatomic, weak) id<SeckillToolBarItemDelegate> delegate;
@end
