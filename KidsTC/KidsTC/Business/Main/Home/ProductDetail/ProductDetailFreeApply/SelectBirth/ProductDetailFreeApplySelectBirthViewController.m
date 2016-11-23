//
//  ProductDetailFreeApplySelectBirthViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplySelectBirthViewController.h"

@interface ProductDetailFreeApplySelectBirthViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineConstraintWidth;
@end

@implementation ProductDetailFreeApplySelectBirthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.naviTheme = NaviThemeWihte;
    
    self.contentView.layer.cornerRadius = 8;
    self.contentView.layer.masksToBounds = YES;
    self.headView.backgroundColor = COLOR_PINK;
    self.HLineConstraintHeight.constant = LINE_H;
    self.VLineConstraintWidth.constant = LINE_H;
    [self.sureBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];

}

- (IBAction)sure:(UIButton *)sender {
    if (self.makeSureBlock) {
        self.makeSureBlock(self.datePicker.date);
    }
    [self back];
}

- (IBAction)cancle:(UIButton *)sender {
    [self back];
}

@end
