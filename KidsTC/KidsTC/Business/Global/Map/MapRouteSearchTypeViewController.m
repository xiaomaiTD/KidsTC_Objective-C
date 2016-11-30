//
//  MapRouteSearchTypeViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/30.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MapRouteSearchTypeViewController.h"

static CGFloat const kAnimationDuration = 0.3;

@interface MapRouteSearchTypeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *taxiBtn;
@property (weak, nonatomic) IBOutlet UIButton *worlkBtn;
@property (weak, nonatomic) IBOutlet UIButton *busBtn;
@property (weak, nonatomic) IBOutlet UIImageView *taxiImg;
@property (weak, nonatomic) IBOutlet UIImageView *worlkImg;
@property (weak, nonatomic) IBOutlet UIImageView *busImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VOneLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VTwoLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewH;

@end

@implementation MapRouteSearchTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.VOneLineH.constant = LINE_H;
    self.VTwoLineH.constant = LINE_H;
    self.contentViewBottomMargin.constant = - self.contentViewH.constant;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view layoutIfNeeded];
    
    self.naviTheme = NaviThemeWihte;
    
    self.taxiBtn.tag = MapRouteSearchTypeDrive;
    self.worlkBtn.tag = MapRouteSearchTypeWalk;
    self.busBtn.tag = MapRouteSearchTypeBus;
    
    [self selectBtn:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
}

- (void)show {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentViewBottomMargin.constant = 0;
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self.view layoutIfNeeded];
    }];
}

- (void)hide {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentViewBottomMargin.constant = - self.contentViewH.constant;
        self.view.backgroundColor = [UIColor clearColor];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self back];
    }];
}


- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock((MapRouteSearchType)sender.tag);
    }
    
    [self selectBtn:sender];
    
    [self hide];
}

- (void)selectBtn:(UIButton *)sender {
    if (sender) {
        self.type = (MapRouteSearchType)sender.tag;
    }
    
    self.taxiImg.hidden = self.type != MapRouteSearchTypeDrive;
    self.worlkImg.hidden = self.type != MapRouteSearchTypeWalk;
    self.busImg.hidden = self.type != MapRouteSearchTypeBus;
}


@end
