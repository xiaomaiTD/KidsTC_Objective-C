//
//  WholesalePickDateViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesalePickDateViewController.h"
#import "WholesalePickDateView.h"

@interface WholesalePickDateViewController ()<WholesalePickDateViewDelegate>
@property (weak, nonatomic) IBOutlet WholesalePickDateView *pickDateView;

@end

@implementation WholesalePickDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
    self.view.backgroundColor = [UIColor clearColor];
    
    self.pickDateView.sku = self.sku;
    self.pickDateView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.pickDateView show];
}


#pragma mark - WholesalePickDateViewDelegate

- (void)wholesalePickDateView:(WholesalePickDateView *)view actionType:(WholesalePickDateViewActionType)type value:(id)value {
    switch (type) {
        case WholesalePickDateViewActionTypeTouchBegin:
        {
            [self touchBegin];
        }
            break;
        case WholesalePickDateViewActionTypeBuy:
        {
            [self buy:value];
        }
            break;
        case WholesalePickDateViewActionTypeMakeSure:
        {
            [self makeSure:value];
        }
            break;
        default:
            break;
    }
}

- (void)touchBegin {
    [self.pickDateView hide:^(BOOL finish) {
        [self back];
    }];
}

- (void)buy:(id)value {
    if ([self.delegate respondsToSelector:@selector(wholesalePickDateViewController:actionType:value:)]) {
        [self.delegate wholesalePickDateViewController:self actionType:WholesalePickDateViewControllerActionTypeBuy value:value];
    }
}

- (void)makeSure:(id)value {
    if ([self.delegate respondsToSelector:@selector(wholesalePickDateViewController:actionType:value:)]) {
        [self.delegate wholesalePickDateViewController:self actionType:WholesalePickDateViewControllerActionTypeMakeSure value:value];
    }
}

@end
