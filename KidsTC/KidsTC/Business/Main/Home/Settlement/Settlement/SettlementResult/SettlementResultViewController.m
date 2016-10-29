//
//  SettlementResultViewController.m
//  KidsTC
//
//  Created by zhanping on 8/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SettlementResultViewController.h"
#import "ServiceOrderDetailViewController.h"
#import "FlashServiceOrderDetailViewController.h"
#import "SettlementResultShareViewController.h"
#import "CommonShareViewController.h"
#import "TabBarController.h"
#import "UIBarButtonItem+Category.h"

#import "GHeader.h"
#import "SettlementResultShareModel.h"


@interface SettlementResultViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTipLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *goHomeBtn;
@end

@implementation SettlementResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10506;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"支付结果";
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem itemWithImageName:@"navigation_close" highImageName:@"navigation_close" postion:UIBarButtonPositionLeft target:self action:@selector(back)];
    
    self.tipLabel.textColor = COLOR_PINK;
    [self.detailBtn setTitleColor:COLOR_YELL forState:UIControlStateNormal];
    [self.goHomeBtn setTitleColor:COLOR_YELL forState:UIControlStateNormal];
    
    self.tipLabel.text = self.paid?@"您已支付成功！":@"支付失败！";
    self.subTipLabel.text = self.paid?@"去玩吧，随便逛逛！":@"您可以查看订单，重新支付！";
    
    if(self.paid) [self loadShareInfo];
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

- (IBAction)detail:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        switch (self.type) {
            case SettlementResultTypeService:
            {
                ServiceOrderDetailViewController *controller = [[ServiceOrderDetailViewController alloc]init];
                controller.orderId = self.orderId;
                [[TabBarController shareTabBarController].selectedViewController pushViewController:controller animated:YES];
            }
                break;
                
            case SettlementResultTypeFlash:
            {
                FlashServiceOrderDetailViewController *controller = [[FlashServiceOrderDetailViewController alloc]init];
                controller.orderId = self.orderId;
                [[TabBarController shareTabBarController].selectedViewController pushViewController:controller animated:YES];
            }
                break;
        }
    }];
}

- (IBAction)goHome:(UIButton *)sender {
    [[TabBarController shareTabBarController] selectIndex:0];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
