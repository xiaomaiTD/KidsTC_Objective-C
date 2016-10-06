//
//  OrderBookingSelectTimeViewController.m
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "OrderBookingSelectTimeViewController.h"
#import "NSString+Category.h"

@interface OrderBookingSelectTimeViewController ()<UIPickerViewDelegate,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (nonatomic, strong)OrderBookingTimeShowModel *currentModel;

@end

@implementation OrderBookingSelectTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.contentView.layer.cornerRadius = 8;
    self.contentView.layer.masksToBounds = YES;
    self.headView.backgroundColor = COLOR_PINK;
    [self.sureBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    
    NSString *recommend = _data.recommendOnlineBespeakTime;
    self.recommendLabel.text = [recommend isNotNull]?recommend:@"";
    
    UITapGestureRecognizer *tapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tapGR1];
    
    UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR2];
    
    NSUInteger row = 0;
    [_pickerView selectRow:row inComponent:0 animated:YES];
    [self pickerView:_pickerView didSelectRow:row inComponent:0];
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
        self.makeSureBlock(_currentModel);
    }
    [self back];
}

- (IBAction)cancleAction:(UIButton *)sender {
    [self back];
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==0) {
        return self.data.timeShowModels.count;
    } else {
        return _currentModel.timesAry.count;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    NSString *str = @"";
    if (component==0) {
        OrderBookingTimeShowModel *model = self.data.timeShowModels[row];
        str = [NSString stringWithFormat:@"%@（%@）",model.dayStr,model.weakStr];
    }else{
        str = _currentModel.timesAry[row];
    }
    if (view) {
        UILabel *label = (UILabel *)view;
        label.text = str;
        return label;
    }else{
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkTextColor];
        label.font = [UIFont systemFontOfSize:15];
        label.text = str;
        return label;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component==0) {
        self.currentModel = self.data.timeShowModels[row];
        [pickerView reloadComponent:1];
    }else{
        _currentModel.selectIndex = row;
    }
}


@end
