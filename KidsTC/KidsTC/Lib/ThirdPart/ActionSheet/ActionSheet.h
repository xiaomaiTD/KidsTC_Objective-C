//
//  Created by 詹平 on 15/6/26.
//  Copyright (c) 2015年 jcjzwork. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActionSheet;
@protocol ActionSheetDelegate<NSObject>
@optional
- (void)didClickActionSheet:(ActionSheet *__nullable)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface ActionSheet:UIView
-(instancetype __nullable)initWithTitle:(NSString *__nullable)title delegate:(id<ActionSheetDelegate>__nullable)delegate cancelButtonTitle:(NSString *__nullable)cancelButtonTitle destructiveButtonTitle:(NSString *__nullable)destructiveButtonTitle otherButtonTitles:(NSString *__nullable)otherButtonTitles,...NS_REQUIRES_NIL_TERMINATION;

- (void)show;
- (void)hide;

@end
