//
//  TCUserRoleSelectViewController.h
//  KidsTC
//
//  Created by zhanping on 5/3/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ViewController.h"
#import "Role.h"
@interface RoleSelectViewController : ViewController
@property (nonatomic, copy) void (^resultBlock)();
@end
