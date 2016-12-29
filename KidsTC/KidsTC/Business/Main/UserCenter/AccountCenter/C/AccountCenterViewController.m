//
//  AccountCenterViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterViewController.h"

#import "GHeader.h"
#import "BuryPointManager.h"
#import "OnlineCustomerService.h"
#import "SegueMaster.h"
#import "NSString+Category.h"
#import "RecommendDataManager.h"

#import "AccountCenterModel.h"

#import "AccountCenterView.h"

#import "SoftwareSettingViewController.h"
#import "NotificationCenterViewController.h"
#import "AccountSettingViewController.h"

#import "CollectProductViewController.h"
#import "CollectionSCTViewController.h"
#import "FavourateViewController.h"
#import "ProductOrderListViewController.h"
#import "CommentTableViewController.h"
#import "CouponListViewController.h"
#import "MyTracksViewController.h"
#import "FlashServiceOrderListViewController.h"
#import "WholesaleOrderListViewController.h"
#import "AppointmentOrderListViewController.h"
#import "ArticleWeChatTableViewController.h"
#import "WebViewController.h"
#import "NurseryViewController.h"


#import "WolesaleProductDetailViewController.h"
#import "WholesaleSettlementViewController.h"
#import "WholesaleOrderDetailViewController.h"


@interface AccountCenterViewController ()<AccountCenterViewDelegate>
@property (nonatomic, strong) AccountCenterModel *model;
@property (nonatomic, strong) AccountCenterView *accountCenterView;
@end

@implementation AccountCenterViewController

- (void)loadView {
    AccountCenterView *accountCenterView = [[AccountCenterView alloc] init];
    accountCenterView.delegate = self;
    self.view = accountCenterView;
    self.accountCenterView = accountCenterView;
    accountCenterView.model = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageId = 10901;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadRecommend:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self loadData];
}

- (void)loadData{
    [Request startWithName:@"GET_USER_CENTER_V2" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadDataSuccess:[AccountCenterModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(AccountCenterModel *)model {
    self.model = model;
    self.accountCenterView.model = model;
}

- (void)loadDataFailure:(NSError *)error {
    
}


#pragma mark - AccountCenterViewDelegate

- (void)accountCenterView:(AccountCenterView *)view actionType:(AccountCenterViewActionType)type value:(id)value {
    [self checkLogin:type relultBlock:^{
        [self checkOverAccountCenterView:view actionType:type value:value];
    }];
}

- (void)checkLogin:(AccountCenterViewActionType)type relultBlock:(void(^)())resultBlock{
    
    switch (type) {
            
        case AccountCenterViewActionTypeMessageCenter:
        case AccountCenterViewActionTypeLogin:
        case AccountCenterViewActionTypeAccountSetting:
            
        case AccountCenterViewActionTypeCollectionProduct:
        case AccountCenterViewActionTypeCollectionStore:
        case AccountCenterViewActionTypeCollectionContent:
        case AccountCenterViewActionTypeCollectionPeople:
            
        case AccountCenterViewActionTypeAllOrder:
        case AccountCenterViewActionTypeWaitPay:
        case AccountCenterViewActionTypeWaitUse:
        case AccountCenterViewActionTypeWaitReceipt:
        case AccountCenterViewActionTypeWaitComment:
        case AccountCenterViewActionTypeRefund:
            
        case AccountCenterViewActionTypeScore:
        case AccountCenterViewActionTypeRadish:
        case AccountCenterViewActionTypeCoupon:
        case AccountCenterViewActionTypeECard:
        case AccountCenterViewActionTypeBalance:
            
        case AccountCenterViewActionTypeHistory:
        case AccountCenterViewActionTypeMyFlash:
        case AccountCenterViewActionTypeMyAppoinment:
            
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                if(resultBlock)resultBlock();
            }];
        }
            break;
            
        case AccountCenterViewActionTypeSoftwareSetting:
        case AccountCenterViewActionTypeRadishMall:
        case AccountCenterViewActionTypeShareMakeMoney:
        case AccountCenterViewActionTypeBringUpHeadline:
        case AccountCenterViewActionTypeCustomerServices:
        case AccountCenterViewActionTypeOpinion:
        case AccountCenterViewActionTypeSegue:
        case AccountCenterViewActionTypeLoadData:
        {
            if(resultBlock)resultBlock();
        }
    }
}

- (void)checkOverAccountCenterView:(AccountCenterView *)view actionType:(AccountCenterViewActionType)type value:(id)value {
    
    UIViewController *toController = nil;
    switch (type) {
        case AccountCenterViewActionTypeSoftwareSetting:
        {
            toController = [[SoftwareSettingViewController alloc]init];
        }
            break;
        case AccountCenterViewActionTypeMessageCenter:
        {
            toController = [[NotificationCenterViewController alloc]init];
        }
            break;
        case AccountCenterViewActionTypeLogin:
        {
            
        }
            break;
        case AccountCenterViewActionTypeAccountSetting:
        {
            AccountCenterUserInfo *userInfo = self.model.data.userInfo;
            AccountSettingModel *model = [AccountSettingModel modelWithHeaderUrl:userInfo.headUrl userName:userInfo.usrName mobile:userInfo.mobile];
            AccountSettingViewController *controller = [[AccountSettingViewController alloc]init];
            controller.model = model;
            toController = controller;
        }
            break;
        case AccountCenterViewActionTypeCollectionProduct:
        {
            toController = [[CollectProductViewController alloc] init];
            [BuryPointManager trackEvent:@"event_skip_usr_favorlist" actionId:21505 params:nil];
        }
            break;
        case AccountCenterViewActionTypeCollectionStore:
        {
            CollectionSCTViewController *controller = [[CollectionSCTViewController alloc] init];
            controller.type = CollectionSCTTypeStore;
            toController = controller;
            [BuryPointManager trackEvent:@"event_skip_usr_favorlist" actionId:21505 params:nil];
        }
            break;
        case AccountCenterViewActionTypeCollectionContent:
        {
            CollectionSCTViewController *controller = [[CollectionSCTViewController alloc] init];
            controller.type = CollectionSCTTypeContent;
            toController = controller;
            [BuryPointManager trackEvent:@"event_skip_usr_favorlist" actionId:21505 params:nil];
        }
            break;
        case AccountCenterViewActionTypeCollectionPeople:
        {
            CollectionSCTViewController *controller = [[CollectionSCTViewController alloc] init];
            controller.type = CollectionSCTTypeTarento;
            toController = controller;
            [BuryPointManager trackEvent:@"event_skip_usr_favorlist" actionId:21505 params:nil];
        }
            break;
        case AccountCenterViewActionTypeAllOrder:
        {
            toController = [[ProductOrderListViewController alloc] initWithType:ProductOrderListTypeAll];
            NSDictionary *params = @{@"type":@(ProductOrderListTypeAll)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeWaitPay:
        {
            toController = [[ProductOrderListViewController alloc] initWithType:ProductOrderListTypeWaitPay];
            NSDictionary *params = @{@"type":@(ProductOrderListTypeWaitPay)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeWaitUse:
        {
            toController = [[ProductOrderListViewController alloc] initWithType:ProductOrderListTypeWaiatUse];
            NSDictionary *params = @{@"type":@(ProductOrderListTypeWaiatUse)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeWaitReceipt:
        {
            toController = [[ProductOrderListViewController alloc] initWithType:ProductOrderListTypeWaitRecive];
            NSDictionary *params = @{@"type":@(ProductOrderListTypeWaitRecive)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeWaitComment:
        {
            CommentTableViewController *controller = [[CommentTableViewController alloc]init];
            controller.isHaveWaitToComment = self.model.data.userCount.order_wait_evaluate>0;
            toController = controller;
            NSDictionary *params = @{@"type":@(ProductOrderListTypeWaitComment)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeRefund:
        {
            toController = [[ProductOrderListViewController alloc] initWithType:ProductOrderListTypeRefund];
            NSDictionary *params = @{@"type":@(ProductOrderListTypeRefund)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeScore:
        {
            
        }
            break;
        case AccountCenterViewActionTypeRadish:
        {
            
        }
            break;
        case AccountCenterViewActionTypeCoupon:
        {
            toController = [[CouponListViewController alloc] init];
            [BuryPointManager trackEvent:@"event_skip_usr_couponlist" actionId:21509 params:nil];
        }
            break;
        case AccountCenterViewActionTypeECard:
        {
            [SegueMaster makeSegueWithModel:self.model.data.config.tcECordLink.segueModel fromController:self];
        }
            break;
        case AccountCenterViewActionTypeBalance:
        {
            [SegueMaster makeSegueWithModel:self.model.data.config.residualLink.segueModel fromController:self];
        }
            break;
        case AccountCenterViewActionTypeHistory:
        {
            toController = [[MyTracksViewController alloc]init];
            [BuryPointManager trackEvent:@"event_skip_usr_history" actionId:21507 params:nil];
        }
            break;
        case AccountCenterViewActionTypeRadishMall:
        {
            NSString *urlString = self.model.data.radish.linkUrl;
            if ([urlString isNotNull]) {
                WebViewController *controller = [[WebViewController alloc]init];
                controller.urlString = urlString;
                toController = controller;
                [BuryPointManager trackEvent:@"event_skip_usr_sign" actionId:21506 params:nil];
            }
        }
            break;
        case AccountCenterViewActionTypeMyFlash:
        {
            toController = [[WholesaleOrderListViewController alloc]init];
            //[BuryPointManager trackEvent:@"event_skip_usr_flashlist" actionId:21511 params:nil];
        }
            break;
        case AccountCenterViewActionTypeMyAppoinment:
        {
            toController = [[AppointmentOrderListViewController alloc] initWithNibName:@"AppointmentOrderListViewController" bundle:nil];
            [BuryPointManager trackEvent:@"event_skip_usr_storelist" actionId:21510 params:nil];
        }
            break;
        case AccountCenterViewActionTypeShareMakeMoney:
        {
            NSString *urlString = self.model.data.invite.linkUrl;
            if ([urlString isNotNull]) {
                WebViewController *controller = [[WebViewController alloc]init];
                controller.urlString = urlString;
                toController = controller;
                [BuryPointManager trackEvent:@"event_skip_usr_sign" actionId:21506 params:nil];
            }
        }
            break;
        case AccountCenterViewActionTypeBringUpHeadline:
        {
            //toController = [[ArticleWeChatTableViewController alloc] init];
            //[BuryPointManager trackEvent:@"event_skip_usr_newstop" actionId:21512 params:nil];
            WolesaleProductDetailViewController *controller = [[WolesaleProductDetailViewController alloc] init];
            controller.productId = @"1";
            toController = controller;
        }
            break;
        case AccountCenterViewActionTypeCustomerServices:
        {
            /*
            NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
            if ([str isNotNull]) {
                WebViewController *controller = [[WebViewController alloc]init];
                controller.urlString = str;
                [self.navigationController pushViewController:controller animated:YES];
            }
            */
            toController = [[WholesaleSettlementViewController alloc] init];
        }
            break;
        case AccountCenterViewActionTypeOpinion:
        {
            /*
            NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
            if ([str isNotNull]) {
                WebViewController *controller = [[WebViewController alloc]init];
                controller.urlString = str;
                [self.navigationController pushViewController:controller animated:YES];
            }
            */
            toController = [[WholesaleOrderDetailViewController alloc] init];
        }
            break;
        case AccountCenterViewActionTypeSegue:
        {
            SegueModel *model = value;
            [SegueMaster makeSegueWithModel:model fromController:self];
            NSMutableDictionary *params = [@{@"type":@(model.destination)} mutableCopy];
            if (model.segueParam && [model.segueParam isKindOfClass:[NSDictionary class]]) {
                [params setObject:model.segueParam forKey:@"params"];
            }
            [BuryPointManager trackEvent:@"event_skip_usr_banner" actionId:21513 params:params];
        }
            break;
        case AccountCenterViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
    }
    if (toController) [self.navigationController pushViewController:toController animated:YES];
}

- (void)loadData:(BOOL)refresh {
    if (refresh) [self loadData];
    [self loadRecommend:refresh];
}

- (void)loadRecommend:(BOOL)refresh {
    [[RecommendDataManager shareRecommendDataManager] loadRecommendProductType:RecommendProductTypeUserCenter refresh:refresh pageCount:TCPAGECOUNT productNos:nil successBlock:^(NSArray<RecommendProduct *> *data) {
        [self.accountCenterView dealWithUI:data.count];
    } failureBlock:^(NSError *error) {
        [self.accountCenterView dealWithUI:0];
    }];
}




@end
