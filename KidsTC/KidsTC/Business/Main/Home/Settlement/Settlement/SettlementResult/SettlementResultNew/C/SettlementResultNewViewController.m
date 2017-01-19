//
//  SettlementResultNewViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SettlementResultNewViewController.h"
#import "UIBarButtonItem+Category.h"
#import "TabBarController.h"
#import "CommonShareViewController.h"
#import "RecommendDataManager.h"
#import "SettlementResultNewView.h"
#import "SegueMaster.h"
#import "NSString+Category.h"

#import "SettlementResultShareViewController.h"
#import "ProductOrderNormalDetailViewController.h"
#import "ProductOrderTicketDetailViewController.h"
#import "ProductOrderFreeDetailViewController.h"
#import "FlashServiceOrderDetailViewController.h"
#import "RadishOrderDetailViewController.h"
#import "WholesaleOrderDetailViewController.h"
#import "WholesaleOrderListViewController.h"

@interface SettlementResultNewViewController ()<SettlementResultNewViewDelegate>
@property (strong, nonatomic) IBOutlet SettlementResultNewView *resultView;
@end

@implementation SettlementResultNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    self.navigationItem.leftBarButtonItem = self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(back) andGetButton:^(UIButton *btn) {
        [btn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateHighlighted];
        btn.imageEdgeInsets = UIEdgeInsetsMake(3, 0, 3, 0);
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }];
    
    switch (_productType) {
        case ProductDetailTypeFree:
        {
            self.navigationItem.title = @"报名成功";
        }
            break;
        default:
        {
            self.navigationItem.title = @"支付结果";
        }
            break;
    }
    
    self.resultView.productType = self.productType;
    self.resultView.delegate = self;
    self.resultView.paid = self.paid;
    self.resultView.data = self.data;
    
    if(self.paid)[self loadShareInfo];
    
    [self loadRecommend:YES];
    
}

- (void)loadShareInfo{
    NSDictionary *param = @{@"orderId":self.orderId};
    [Request startWithName:@"GET_PAID_SHARE_INFO" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadShareInfoSuccess:[SettlementResultShareModel modelWithDictionary:dic]];
    } failure:nil];
}

- (void)loadShareInfoSuccess:(SettlementResultShareModel *)model{
    if (model.data.shareObj) {
        SettlementResultShareViewController *controller = [[SettlementResultShareViewController alloc]initWithNibName:@"SettlementResultShareViewController" bundle:nil];
        controller.model = model;
        controller.resultBlock =^void(SettlementResultShareData *data){
            CommonShareViewController *shareVC = [CommonShareViewController instanceWithShareObject:data.shareObj sourceType:data.userShareType];
            [self presentViewController:shareVC animated:YES completion:nil];
        };
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        controller.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark - SettlementResultNewViewDelegate

- (void)settlementResultNewView:(SettlementResultNewView *)view actionType:(SettlementResultNewViewActionType)type value:(id)value {
    switch (type) {
        case SettlementResultNewViewActionTypeOrderDetail:
        {
            [self detail:value];
        }
            break;
        case SettlementResultNewViewActionTypeGoHome:
        {
            [self goHome:value];
        }
            break;
        case SettlementResultNewViewActionTypeLoadRecommend:
        {
            [self loadRecommend:[value boolValue]];
        }
            break;
        case SettlementResultNewViewActionTypeSegue:
        {
            [self segue:value];
        }
            break;
    }
}

- (void)loadRecommend:(BOOL)refresh {
    [[RecommendDataManager shareRecommendDataManager] loadRecommendProductType:self.recommendType refresh:refresh pageCount:TCPAGECOUNT productNos:nil successBlock:^(NSArray<RecommendProduct *> *data) {
        [self.resultView reloadData:data.count];
    } failureBlock:^(NSError *error) {
        [self.resultView reloadData:0];
    }];
}

- (RecommendProductType)recommendType {
    RecommendProductType recommendType = RecommendProductTypeNormal;
    switch (_productType) {
        case ProductDetailTypeTicket:
        {
            recommendType = RecommendProductTypeTicket;
        }
            break;
        case ProductDetailTypeFree:
        {
            recommendType = RecommendProductTypeFree;
        }
            break;
        case ProductDetailTypeRadish:
        {
            recommendType = RecommendProductTypeRadish;
        }
            break;
        default:
        {
            recommendType = RecommendProductTypeNormal;
        }
            break;
    }
    return recommendType;
}

- (void)detail:(id)value {
    [self dismissViewControllerAnimated:YES completion:^{
        __kindof UIViewController *target = [TabBarController shareTabBarController].selectedViewController;
        switch (self.productType) {
            case ProductDetailTypeTicket:
            {
                ProductOrderTicketDetailViewController *controller = [[ProductOrderTicketDetailViewController alloc] init];
                controller.orderId = self.orderId;
                [target pushViewController:controller animated:YES];
            }
                break;
            case ProductDetailTypeFree:
            {
                ProductOrderFreeDetailViewController *controller = [[ProductOrderFreeDetailViewController alloc] init];
                controller.orderId = self.orderId;
                [target pushViewController:controller animated:YES];
            }
                break;
            case ProductDetailTypeWholesale:
            {
                if ([self.openGroupId isNotNull]) {
                    WholesaleOrderDetailViewController *controller = [[WholesaleOrderDetailViewController alloc] init];
                    controller.productId = self.productId;
                    controller.openGroupId = self.openGroupId;
                    [target pushViewController:controller animated:YES];
                }else{
                    WholesaleOrderListViewController *controller = [[WholesaleOrderListViewController alloc] init];
                    [target pushViewController:controller animated:YES];
                }
            }
                break;
            case ProductDetailTypeRadish:
            {
                RadishOrderDetailViewController *controller = [[RadishOrderDetailViewController alloc] init];
                controller.orderId = self.orderId;
                [target pushViewController:controller animated:YES];
            }
                break;
            case ProductDetailTypeFalsh:
            {
                FlashServiceOrderDetailViewController *controller = [[FlashServiceOrderDetailViewController alloc]init];
                controller.orderId = self.orderId;
                [target pushViewController:controller animated:YES];
            }
                break;
            default:
            {
                ProductOrderNormalDetailViewController *controller = [[ProductOrderNormalDetailViewController alloc] init];
                controller.orderId = self.orderId;
                [target pushViewController:controller animated:YES];
            }
                break;
        }
    }];
}

- (void)goHome:(id)value {
    [[TabBarController shareTabBarController] selectIndex:0];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)segue:(id)value {
    [self dismissViewControllerAnimated:YES completion:^{
        UINavigationController *navi = [TabBarController shareTabBarController].selectedViewController;
        [SegueMaster makeSegueWithModel:value fromController:navi.topViewController];
    }];
}

@end
