//
//  BindPhoneViewController.h
//  KidsTC
//
//  Created by 詹平 on 16/7/19.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ViewController.h"
@protocol BindPhoneViewControllerDelegate <NSObject>
- (void)didFinishedBindPoneActionWithUid:(NSString *)uid;
@end

@interface BindPhoneViewController : ViewController
@property (nonatomic, weak) id<BindPhoneViewControllerDelegate> delegate;
@end
