//
//  ScoreExchangeViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreExchangeViewController.h"
#import "ScoreExchangeInputView.h"
#import "GHeader.h"
#import "NSString+Category.h"
@interface ScoreExchangeViewController ()<ScoreExchangeInputViewDelegate>
@property (weak, nonatomic) IBOutlet ScoreExchangeInputView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@end

@implementation ScoreExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    self.view.backgroundColor = [UIColor clearColor];
    self.inputView.userInfoData = self.userInfoData;
    self.inputView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.inputView startInput:YES];
    [UIView animateWithDuration:0.2 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
}
- (IBAction)close:(UIButton *)sender {
    [self.inputView startInput:NO];
    [self back];
}

#pragma mark ScoreExchangeInputViewDelegate

- (void)scoreExchangeInputView:(ScoreExchangeInputView *)view exchangeRadishNum:(NSInteger)radishNum scoreNum:(NSInteger)scoreNum {
    NSDictionary *param = @{@"radishNum":@(radishNum),
                            @"scoreNum":@(scoreNum)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"RADISH_EXCHANGE_SCORE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        if ([self.delegate respondsToSelector:@selector(scoreExchangeViewControllerDidExchangeSuccess:)]) {
            [self.delegate scoreExchangeViewControllerDidExchangeSuccess:self];
        }
        [self close:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        NSString *errMsg = @"兑换积分失败，请稍后再试！";
        NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
        if ([text isNotNull]) errMsg = text;
        [[iToast makeText:errMsg] show];
    }];
}

- (void)keyboardWillShow:(NSNotification *)noti {
    [super keyboardWillShow:noti];
    self.bottomMargin.constant = self.keyboardHeight;
    [self.view layoutIfNeeded];
}
- (void)keyboardWillDisappear:(NSNotification *)noti {
    [super keyboardWillDisappear:noti];
    self.bottomMargin.constant = 0;
    [self.view layoutIfNeeded];
}

@end
