//
//  ArticleWriteAlertSuccessResultViewController.m
//  KidsTC
//
//  Created by zhanping on 2016/9/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleWriteAlertSuccessResultViewController.h"

@interface ArticleWriteAlertSuccessResultViewController ()
@property (weak, nonatomic) IBOutlet UIView *BGContentView;
@property (weak, nonatomic) IBOutlet UIView *titleContentView;
@property (weak, nonatomic) IBOutlet UIView *btnContentView;
@property (weak, nonatomic) IBOutlet UIButton *writeMoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BGViewCenterYConstraint;
@end

@implementation ArticleWriteAlertSuccessResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _BGContentView.layer.cornerRadius = 8;
    _BGContentView.layer.masksToBounds = YES;
    _titleContentView.backgroundColor = COLOR_PINK;
    _sureBtn.backgroundColor = COLOR_PINK;
    _sureBtn.layer.cornerRadius = 4;
    _sureBtn.layer.masksToBounds = YES;
    
    _writeMoreBtn.tag = ArticleWriteAlertSuccessResultBtnTypeWriteMore;
    _shareBtn.tag = ArticleWriteAlertSuccessResultBtnTypeShare;
    _sureBtn.tag = ArticleWriteAlertSuccessResultBtnTypeMakeSure;
    
    self.BGViewCenterYConstraint.constant = (SCREEN_HEIGHT+_BGContentView.frame.size.height)*0.5;
    [self.BGContentView setNeedsLayout];
    [self.BGContentView layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showAnimate];
}

- (void)showAnimate {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.BGViewCenterYConstraint.constant = 0;
        [self.BGContentView setNeedsLayout];
        [self.BGContentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.BGContentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.BGContentView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

- (void)dimissAnimate:(void(^)(BOOL finish))completion {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
        self.BGViewCenterYConstraint.constant = (SCREEN_HEIGHT+_BGContentView.frame.size.height)*0.5;
        [self.BGContentView setNeedsLayout];
        [self.BGContentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion) completion(finished);
    }];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (IBAction)actions:(UIButton *)sender {
    [self dimissAnimate:^(BOOL finish) {
        [self dismissViewControllerAnimated:NO completion:^{
            if ([self.delegate respondsToSelector:@selector(articleWriteAlertSuccessResultViewController:actionType:)]) {
                [self.delegate articleWriteAlertSuccessResultViewController:self actionType:(ArticleWriteAlertSuccessResultBtnType)sender.tag];
            }
        }];
    }];
}


@end
