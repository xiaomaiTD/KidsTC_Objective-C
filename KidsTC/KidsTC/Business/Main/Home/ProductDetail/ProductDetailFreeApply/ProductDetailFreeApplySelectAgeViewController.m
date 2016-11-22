//
//  ProductDetailFreeApplySelectAgeViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplySelectAgeViewController.h"

@interface ProductDetailFreeApplySelectAgeViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineConstraintWidth;

@end

@implementation ProductDetailFreeApplySelectAgeViewController

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
    
    UITapGestureRecognizer *tapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tapGR1];
    
    UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR2];
    
    [_pickerView selectRow:_age inComponent:0 animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if (tapGR.view == self.view) {
        [self back];
    }
}

- (IBAction)sureAction:(UIButton *)sender {
    if (self.makeSureBlock) {
        self.makeSureBlock(_age);
    }
    [self back];
}

- (IBAction)cancleAction:(UIButton *)sender {
    [self back];
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 13;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%zd",row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.age = row;
}

@end
