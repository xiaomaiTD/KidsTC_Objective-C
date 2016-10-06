//
//  SettlementResultShareViewController.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SettlementResultShareViewController.h"
#import "CommonShareViewController.h"
@interface SettlementResultShareViewController ()

@end

@implementation SettlementResultShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.titleLabel.textColor = COLOR_PINK;
    self.titleLabel.text = self.model.data.shareTips;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (IBAction)close:(UIButton *)sender {
    [self back];
}
- (IBAction)share:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.resultBlock) self.resultBlock(self.model.data);
    }];
}

@end
