//
//  WelcomeViewController.h
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"
@interface WelcomeViewController : ViewController
@property (nonatomic, copy) void(^resultBlock)();
@property (nonatomic, weak) NSArray<UIImage *> *images;
@end
