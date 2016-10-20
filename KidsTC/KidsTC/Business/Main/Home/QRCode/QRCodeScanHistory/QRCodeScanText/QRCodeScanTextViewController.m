//
//  QRCodeScanTextViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "QRCodeScanTextViewController.h"

@interface QRCodeScanTextViewController ()
@property (weak, nonatomic) IBOutlet UIView *textContainerView;
@property (weak, nonatomic) IBOutlet UILabel *textL;
@end

@implementation QRCodeScanTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"文本信息";
    self.view.backgroundColor = [UIColor colorWithRed:0.953 green:0.961 blue:0.969 alpha:1];
    self.textContainerView.layer.cornerRadius = 8;
    self.textContainerView.layer.masksToBounds = YES;
    [self.view layoutIfNeeded];
    
    self.textL.text = self.text;
}


@end
