//
//  UIAlertView+Category.h
//  FileTransfer
//
//  Created by 平 on 16/1/1.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AlertBlock)(NSInteger buttonIndex);
@interface UIAlertView (Category)<UIAlertViewDelegate>

+(UIAlertView *)alertBlock:(AlertBlock)alertBlock Title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
