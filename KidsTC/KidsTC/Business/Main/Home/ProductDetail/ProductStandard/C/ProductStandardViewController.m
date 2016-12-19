//
//  ProductStandardViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductStandardViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "ProductStandardDetailModel.h"

#import "ProductStandardView.h"

@interface ProductStandardViewController ()<ProductStandardViewDelegate>
@property (strong, nonatomic) IBOutlet ProductStandardView *standardView;
@end

@implementation ProductStandardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.standardView.delegate = self;
    self.standardView.product_standards = self.product_standards;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.standardView show];
}


#pragma mark - ProductStandardViewDelegate

- (void)productStandardView:(ProductStandardView *)view actionType:(ProductStandardViewActionType)type value:(id)value {
    switch (type) {
        case ProductStandardViewActionTypeDidSelectStandard:
        {
            [self didSelectStandard:value];
        }
            break;
        case ProductStandardViewActionTypeClose:
        {
            [self close:value];
        }
            break;
        case ProductStandardViewActionTypeBuy:
        {
            [self buy:value];
        }
            break;
    }
}

- (void)didSelectStandard:(id)value {
    [self loadProductStandardDetail:value];
    if ([self.delegate respondsToSelector:@selector(productStandardViewController:actionType:value:)]) {
        [self.delegate productStandardViewController:self actionType:ProductStandardViewControllerActionTypDidSelectStandard value:value];
    }
}

- (void)loadProductStandardDetail:(NSString *)pid {
    if (![pid isNotNull]) {
        [[iToast makeText:@"该套餐管理商品编号为空"] show];
        return;
    }
    NSDictionary *parameter = @{@"pid":pid};
    [Request startWithName:@"GET_PRODUCT_STANDARD" param:parameter progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductStandardDetailData *data = [ProductStandardDetailModel modelWithDictionary:dic].data;
        self.standardView.standardDetailData = data;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (void)close:(id)value {
    [self.standardView hide:^{
        [self back];
    }];
}

- (void)buy:(id)value {
    [self.standardView hide:^{
        if ([self.delegate respondsToSelector:@selector(productStandardViewController:actionType:value:)]) {
            [self.delegate productStandardViewController:self actionType:ProductStandardViewControllerActionTypBuyStandard value:value];
        }
        [self back];
    }];
}


@end
