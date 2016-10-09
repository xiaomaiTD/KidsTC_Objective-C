//
//  UIAlertView+Category.m
//  FileTransfer
//
//  Created by 平 on 16/1/1.
//  Copyright © 2016年 ping. All rights reserved.
//
/*
 ===消除过时编译警告===
 
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wdeprecated-declarations"
 这里写出现警告的代码
 
 #pragma clang diagnostic pop
 
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#import "UIAlertView+Category.h"
#import <objc/runtime.h>
@implementation UIAlertView (Category)
const void *alertBlockKey = @"alertBlockKey";


+(UIAlertView *)alertBlock:(AlertBlock)alertBlock Title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    alertView.delegate = alertView;
    
    va_list list;
    va_start(list, otherButtonTitles);
    while (YES)
    {
        NSString *otherTitle = va_arg(list, NSString*);
        if (!otherTitle){
            break;
        }
        [alertView addButtonWithTitle:otherTitle];
    }
    va_end(list);
    

    objc_setAssociatedObject(alertView, alertBlockKey, alertBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [alertView show];
    
    return alertView;
}



#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    AlertBlock alertBlock = objc_getAssociatedObject(self, alertBlockKey);
    if (alertBlock) {
        alertBlock(buttonIndex);
    }
    
}

@end

#pragma clang diagnostic pop


