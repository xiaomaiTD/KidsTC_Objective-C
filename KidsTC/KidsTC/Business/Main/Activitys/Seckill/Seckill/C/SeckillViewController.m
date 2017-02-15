//
//  SeckillViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "UIBarButtonItem+Category.h"
#import "SegueMaster.h"
#import "TabBarController.h"
#import "BuryPointManager.h"

#import "SeckillTitleView.h"

#import "SeckillTimeModel.h"
#import "SeckillDataModel.h"
#import "SeckillOtherModel.h"
#import "SeckillView.h"

#import "CommonShareViewController.h"
#import "ProductOrderListViewController.h"
#import "SeckillOtherViewController.h"

@interface SeckillViewController ()<SeckillViewDelegate>
@property (strong, nonatomic) IBOutlet SeckillView *seckillView;
@property (nonatomic, strong) SeckillTimeData *timeData;
@property (nonatomic, strong) SeckillDataData *dataData;
@property (nonatomic, strong) NSArray<SeckillOtherItem *> *otherData;
@end

@implementation SeckillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    
    self.pageId = 11400;
    
    SeckillTitleView *titleView = [[NSBundle mainBundle] loadNibNamed:@"SeckillTitleView" owner:self options:nil].firstObject;
    titleView.frame = CGRectMake(0, 0, 80, 19);
    self.navigationItem.titleView = titleView;
    
    self.seckillView.delegate = self;
    
    [self loadSeckill];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(share) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [btn setImage:[UIImage imageNamed:@"wholesale_share"] forState:UIControlStateNormal];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(SCREEN_WIDTH, LINE_H)]];
}

- (void)share {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.timeData.shareObject sourceType:KTCShareServiceTypeSeckill];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)loadSeckill {
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_SEC_KILL_EVENT_TAB" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        SeckillTimeData *data = [SeckillTimeModel modelWithDictionary:dic].data;
        if (data) {
            [self loadSeckillSuccess:data];
        }else{
            [self loadSeckillFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadSeckillFailure:error];
    }];
}

- (void)loadSeckillSuccess:(SeckillTimeData *)data {
    self.timeData = data;
    self.seckillView.timeData = data;
    [self loadOther];
}

- (void)loadSeckillFailure:(NSError *)error {
    [[iToast makeText:@"获取秒杀信息失败，请稍后再试！"] show];
    [self back];
}

- (void)loadOther {
    NSString *menu_id = [NSString stringWithFormat:@"%@",self.timeData.eventMenu.param[@"fid"]];
    if (![menu_id isNotNull]) {
        return;
    }
    NSDictionary *param = @{@"menu_id":menu_id};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_EVENT_TAB_MENU_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        NSArray<SeckillOtherItem *> *data = [SeckillOtherModel modelWithDictionary:dic].data;
        if (data.count>0) {
            [self loadOtherSuccess:data];
        }else{
            [self loadOtherFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadOtherFailure:error];
    }];
}

- (void)loadOtherSuccess:(NSArray<SeckillOtherItem *> *)data {
    self.otherData = data;
}

- (void)loadOtherFailure:(NSError *)error {
    //[[iToast makeText:@"获取其他优惠活动失败,请稍后再试"] show];
}

#pragma mark - SeckillViewDelegate

- (void)seckillView:(SeckillView *)view actionType:(SeckillViewActionType)type value:(id)value {
    switch (type) {
        case SeckillViewActionTypeSegue:
        {
            [self segue:value];
        }
            break;
        case SeckillViewActionTypeRemind:
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                [self remind:value];
            }];
        }
            break;
        case SeckillViewActionTypeSeckillTime:
        {
            [self seckillTime:value];
        }
            break;
        case SeckillViewActionTypeCountDownOver:
        {
            [self loadSeckill];
        }
            break;
        case SeckillViewActionTypeHome:
        {
            [self goHome];
        }
            break;
        case SeckillViewActionTypePocket:
        {
            [self pocket];
        }
            break;
        case SeckillViewActionTypeOther:
        {
            [self other];
        }
            break;
    }
}

#pragma mark segue

- (void)segue:(id)value {
    [SegueMaster makeSegueWithModel:value fromController:self];
}

#pragma mark remind

- (void)remind:(id)value {
    if (![value isKindOfClass:[SeckillDataItem class]]) return;
    SeckillDataItem *item = value;
    NSString *productId = item.productNo;
    if (![productId isNotNull]) {
        return;
    }
    NSString *chId = item.channelId;
    if (![chId isNotNull]) {
        chId = @"0";
    }
    NSString *type = @"1";
    NSDictionary *param = @{@"productId":productId,
                            @"chId":chId,
                            @"type":type};;
    [TCProgressHUD showSVP];
    [Request startWithName:@"REMIND_SEC_KILL_POOL_ITEM" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"设置提醒成功！"] show];
        item.status = SeckillDataItemBtnStatusHasRemind;
        [self.seckillView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"设置提醒失败，请稍后再试！"] show];
    }];
}

#pragma mark seckillTime

- (void)seckillTime:(id)value {
    if (![value isKindOfClass:[SeckillTimeTime class]]) return;
    SeckillTimeTime *item = value;
    NSString *poolTermNo = item.poolTermSysNo;
    if (![poolTermNo isNotNull]) {
        return;
    }
    NSDictionary *param = @{@"poolTermNo":poolTermNo};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_SEC_KILL_EVENT_ITEM_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        SeckillDataData *data = [SeckillDataModel modelWithDictionary:dic].data;
        [self loadSeckillDataSuccess:data];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadSeckillDataFailure:error];
    }];
    
    NSDictionary *params = @{@"id":poolTermNo};
    [BuryPointManager trackEvent:@"event_click_seckill_change_time" actionId:22001 params:params];
}

- (void)loadSeckillDataSuccess:(SeckillDataData *)data {
    self.dataData = data;
    self.seckillView.dataData = data;
}

- (void)loadSeckillDataFailure:(NSError *)error {
    
}

#pragma mark goHome

- (void)goHome {
    [[TabBarController shareTabBarController] selectIndex:0];
}

#pragma mark pocket

- (void)pocket {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ProductOrderListViewController *controller = [[ProductOrderListViewController alloc] initWithType:ProductOrderListTypeAll];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

#pragma mark other
- (void)other {
    if (self.otherData.count<1) return;
    SeckillOtherViewController *controller = [[SeckillOtherViewController alloc] initWithNibName:@"SeckillOtherViewController" bundle:nil];
    controller.data = self.otherData;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
