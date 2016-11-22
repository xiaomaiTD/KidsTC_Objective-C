//
//  ProductDetailFreeApplySelectSexViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplySelectSexViewController.h"

@interface ProductDetailFreeApplySelectSexViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineConstraintWidth;
@property (nonatomic, strong) NSArray<NSDictionary *> *sexs;

@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation ProductDetailFreeApplySelectSexViewController

- (NSArray<NSDictionary *> *)sexs {
    if (!_sexs) {
        NSDictionary *boy = @{@"男":@(TCSexTypeBoy)};
        NSDictionary *girl = @{@"女":@(TCSexTypeGirl)};
        _sexs = @[boy,girl];
    }
    return _sexs;
}

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
        if (self.currentIndex<self.sexs.count) {
            NSDictionary *sexDic = self.sexs[self.currentIndex];
            self.makeSureBlock(sexDic);
        } else self.makeSureBlock(nil);
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
    return self.sexs.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row<self.sexs.count) {
        NSDictionary *sexDic = self.sexs[row];
        if (sexDic.allKeys.count>0) {
            return sexDic.allKeys.firstObject;
        }
        return @"";
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.currentIndex = row;
}

@end
