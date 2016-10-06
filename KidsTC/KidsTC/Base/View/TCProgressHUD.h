//
//  TCProgressHUD.h
//  KidsTC
//
//  Created by zhanping on 8/20/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCProgressHUD : UIView
+ (void)show;
+(void)showInView:(UIView *)view;
+ (void)dismiss;

+ (void)showSVP;
+ (void)dismissSVP;
@end
