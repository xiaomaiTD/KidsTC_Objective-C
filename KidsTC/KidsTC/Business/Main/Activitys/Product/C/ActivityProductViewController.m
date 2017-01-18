//
//  ActivityProductViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductViewController.h"
#import "GHeader.h"
#import "UIBarButtonItem+Category.h"
#import "NSString+Category.h"
#import "SegueMaster.h"

#import "ActivityProductModel.h"
#import "SeckillOtherModel.h"
#import "ActivityProductView.h"

#import "CommonShareViewController.h"
#import "SeckillOtherViewController.h"

@interface ActivityProductViewController ()<ActivityProductViewDelegate>
@property (nonatomic, strong) ActivityProductView *productView;
@property (nonatomic, strong) ActivityProductData *data;
@property (nonatomic, strong) NSArray<SeckillOtherItem *> *otherData;
@end

@implementation ActivityProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ID = @"E7-92-F0-91-75-A7-E1-ED_50";
    
    if (![_ID isNotNull]) {
        [[iToast makeText:@"活动编号为空"] show];
        [self back];
        return;
    }
    
    self.pageId = 11401;
    self.trackParams = @{@"id":_ID};
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"服务活动";
    
    ActivityProductView *productView = [[ActivityProductView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    productView.delegate = self;
    [self.view addSubview:productView];
    self.productView = productView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(share) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [btn setImage:[UIImage imageNamed:@"wholesale_share"] forState:UIControlStateNormal];
    }];
    
    [self loadData];
}

- (void)share {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.data.shareObj sourceType:KTCShareServiceTypeEvent];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)loadData {
    NSDictionary *param = @{@"id":_ID};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_EVENT_DETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ActivityProductData *data = [ActivityProductModel modelWithDictionary:dic].data;
        if (data.showFloorItems.count>0) {
            [self loadDataSuccess:data];
        }else{
            [self loadDataFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(ActivityProductData *)data {
    self.data = data;
    self.productView.data = data;
    [self loadOther];
}

- (void)loadDataFailure:(NSError *)error {
    [[iToast makeText:@"获取活动信息失败，请稍后再试！"] show];
    [self back];
}

- (void)loadOther {
    
    NSArray<ActivityProductTabItem *> *tabItems = self.data.toolBarContent.tabItems;
    if (tabItems.count<1) return;
    
    __block NSString *fid = nil;
    [tabItems enumerateObjectsUsingBlock:^(ActivityProductTabItem *tabItem, NSUInteger idx, BOOL *stop) {
        switch (tabItem.segueModel.destination) {
            case SegueDestinationOtherActivity:
            {
                NSString *tabItemFid = [NSString stringWithFormat:@"%@",tabItem.params[@"fid"]];
                if (![fid isNotNull] && [tabItemFid isNotNull]) {
                    fid = tabItemFid;
                }
            }
                break;
            default:
                break;
        }
    }];
    if (![fid isNotNull]) return;
    
    NSString *menu_id = fid;
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

#pragma mark - ActivityProductViewDelegate

- (void)activityProductView:(ActivityProductView *)view actionType:(ActivityProductViewActionType)type value:(id)value {
    switch (type) {
        case ActivityProductViewActionTypeSegue:
        {
            [self segue:value];
        }
            break;
        case ActivityProductViewActionTypeCoupon:
        {
            [self getCoupon:value];
        }
            break;
        default:
            break;
    }
}

- (void)segue:(id)value {
    
    if (![value isKindOfClass:[SegueModel class]]) return;
    
    SegueModel *segueModel = value;
    switch (segueModel.destination) {
        case SegueDestinationOtherActivity:
        {
            [self other];
        }
            break;
            
        default:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
    }
}

- (void)other {
    if (self.otherData.count<1) return;
    SeckillOtherViewController *controller = [[SeckillOtherViewController alloc] initWithNibName:@"SeckillOtherViewController" bundle:nil];
    controller.data = self.otherData;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)getCoupon:(id)value {
    if (![value isKindOfClass:[ActivityProductCoupon class]]) return;
    ActivityProductCoupon *coupon = value;
    NSString *batchNo = coupon.batchNo;
    if (![batchNo isNotNull]) {
        [[iToast makeText:@"该优惠券暂不支持领取"] show];
        return;
    }
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        NSDictionary *param = @{@"batchid":batchNo};
        [TCProgressHUD showSVP];
        [Request startWithName:@"COUPON_FETCH" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            [TCProgressHUD dismissSVP];
            NSString *errMsg = @"恭喜您，优惠券领取成功！";
            [[iToast makeText:errMsg] show];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [TCProgressHUD dismissSVP];
            NSString *errMsg = @"领取优惠券失败，请稍后再试~";
            NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
            if ([text isNotNull]) errMsg = text;
            [[iToast makeText:errMsg] show];
        }];
    }];
}

@end
