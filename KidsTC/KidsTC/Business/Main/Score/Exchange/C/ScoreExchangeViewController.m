//
//  ScoreExchangeViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreExchangeViewController.h"
#import "ScoreExchangeInputView.h"

@interface ScoreExchangeViewController ()
@property (weak, nonatomic) IBOutlet ScoreExchangeInputView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;



@end

@implementation ScoreExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    self.view.backgroundColor = [UIColor clearColor];
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
