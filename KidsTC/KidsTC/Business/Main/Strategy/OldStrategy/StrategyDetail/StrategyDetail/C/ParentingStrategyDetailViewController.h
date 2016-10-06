//
//  ParentingStrategyDetailViewController.h
//  KidsTC
//
//  Created by 钱烨 on 10/9/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ViewController.h"

@interface ParentingStrategyDetailViewController : ViewController
@property (nonatomic, copy) void (^changeLikeBtnStatusBlock)();

- (instancetype)initWithStrategyIdentifier:(NSString *)identifier;

@end
