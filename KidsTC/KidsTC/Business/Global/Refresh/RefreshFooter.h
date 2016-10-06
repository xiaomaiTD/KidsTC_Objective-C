//
//  RefreshFooter.h
//  KidsTC
//
//  Created by 詹平 on 16/7/9.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "MJRefresh.h"

@interface RefreshFooter : MJRefreshBackStateFooter
/** 是否自动刷新(默认为YES) */
@property (assign, nonatomic, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;
//
/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
@property (assign, nonatomic) CGFloat appearencePercentTriggerAutoRefresh MJRefreshDeprecated("请使用triggerAutomaticallyRefreshPercent属性");

/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
@property (assign, nonatomic) CGFloat triggerAutomaticallyRefreshPercent;
@end
