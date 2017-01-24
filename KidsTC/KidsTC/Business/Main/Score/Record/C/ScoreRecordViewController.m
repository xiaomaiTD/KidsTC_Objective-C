//
//  ScoreRecordViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreRecordViewController.h"

#import "ScoreRecordView.h"

@interface ScoreRecordViewController ()
@property (strong, nonatomic) IBOutlet ScoreRecordView *recordView;
@end

@implementation ScoreRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"积分明细";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

@end
