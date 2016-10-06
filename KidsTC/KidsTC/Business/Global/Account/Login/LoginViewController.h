//
//  LoginViewController.h
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ViewController.h"
typedef void (^LoginResultBlock)(NSString *uid, NSError*error);
@interface LoginViewController : ViewController
@property (nonatomic, copy) LoginResultBlock resultBlock;
@end
