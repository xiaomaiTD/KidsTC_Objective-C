//
//  ViewController.h
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) UIColor *naviColor;
@property (nonatomic, strong) NSString *pageId;
@property (nonatomic, assign) CGFloat keyboardHeight;
- (void)back;
#pragma mark Keyboard Notification
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillDisappear:(NSNotification *)notification;
@end
