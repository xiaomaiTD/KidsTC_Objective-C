//
//  ProductDetailFreeApplyViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyViewController.h"
#import "SettlementResultNewViewController.h"

@interface ProductDetailFreeApplyViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeLineH;

@end

@implementation ProductDetailFreeApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"填写报名信息";
    self.naviTheme = NaviThemeWihte;
    
    self.sureBtn.backgroundColor = COLOR_PINK;
    self.sureBtn.layer.cornerRadius = 4;
    self.sureBtn.layer.masksToBounds = YES;
    
    self.oneLineH.constant = LINE_H;
    self.twoLineH.constant = LINE_H;
    self.threeLineH.constant = LINE_H;
    
    [self.view layoutIfNeeded];
    
}

- (IBAction)sure:(UIButton *)sender {
    
    SettlementResultNewViewController *controller = [[SettlementResultNewViewController alloc] initWithNibName:@"SettlementResultNewViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
