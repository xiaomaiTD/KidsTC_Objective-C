//
//  SharePaidInfoView.h
//  KidsTC
//
//  Created by zhanping on 5/9/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharePaidInfoView : UIView
@property (nonatomic, weak) UILabel *tipLabel;
@property (nonatomic, copy) void (^didClickShareBtn)();
@end
