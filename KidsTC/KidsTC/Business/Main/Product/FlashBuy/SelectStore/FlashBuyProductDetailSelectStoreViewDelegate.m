//
//  FlashBuyProductDetailSelectStoreViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailSelectStoreViewController.h"

#import "FlashBuyProductDetailSelectStoreView.h"

@interface FlashBuyProductDetailSelectStoreViewController ()<FlashBuyProductDetailSelectStoreViewDelegate>
@property (strong, nonatomic) IBOutlet FlashBuyProductDetailSelectStoreView *selectStoreView;
@end

@implementation FlashBuyProductDetailSelectStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.naviTheme = NaviThemeWihte;
    self.view.backgroundColor = [UIColor clearColor];
    self.selectStoreView.stores = self.stores;
    self.selectStoreView.prepaidPrice = self.prepaidPrice;
    self.selectStoreView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.selectStoreView show];
}

- (void)flashBuyProductDetailSelectStoreView:(FlashBuyProductDetailSelectStoreView *)view actionType:(FlashBuyProductDetailSelectStoreViewActionType)type value:(id)value {
    switch (type) {
        case FlashBuyProductDetailSelectStoreViewActionTypeTouchBegin:
        {
            [self touchBegin];
        }
            break;
        case FlashBuyProductDetailSelectStoreViewActionTypeCommit:
        {
            [self commit:value];
        }
            break;
        default:
            break;
    }
}

- (void)touchBegin {
    [self.selectStoreView hide:^(BOOL finish) {
        [self back];
    }];
}

- (void)commit:(id)value{
    if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailSelectStoreViewController:actionType:value:)]) {
        [self.delegate flashBuyProductDetailSelectStoreViewController:self actionType:FlashBuyProductDetailSelectStoreViewControllerActionTypeCommit value:value];
    }
}

@end
