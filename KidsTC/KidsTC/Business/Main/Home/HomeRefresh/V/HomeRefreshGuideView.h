//
//  HomeRefreshGuideView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeRefreshGuideView : UIView
@property (nonatomic, copy) void (^resultBlock)();
@property (nonatomic, assign) CGFloat top;
@end
