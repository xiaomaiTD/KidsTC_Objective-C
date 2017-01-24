//
//  ScoreCenterViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreCenterViewController.h"
#import "ScoreCenterView.h"

@interface ScoreCenterViewController ()
@property (strong, nonatomic) IBOutlet ScoreCenterView *centerView;
@end

@implementation ScoreCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"积分";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


@end
