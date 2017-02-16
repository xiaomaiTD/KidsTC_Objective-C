//
//  ScoreEarnViewController.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreEarnViewController.h"
#import "ScoreEarnView.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "SegueMaster.h"

#import "ScoreUserInfoModel.h"
#import "ScoreOrderModel.h"
#import "ScoreProductModel.h"

#import "WebViewController.h"
#import "RadishMallViewController.h"
#import "ScoreExchangeViewController.h"
#import "CommentFoundingViewController.h"
#import "FlashServiceOrderDetailViewController.h"

@interface ScoreEarnViewController ()<ScoreEarnViewDelegate,CommentFoundingViewControllerDelegate,ScoreExchangeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet ScoreEarnView *earnView;
@property (nonatomic,assign) NSUInteger page_comment;
@property (nonatomic,assign) NSUInteger page_products;

@property (nonatomic,strong) ScoreUserInfoData *userInfoData;
@property (nonatomic,  weak) ScoreOrderItem *commentOrder;
@end

@implementation ScoreEarnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"童成会员";
    self.earnView.delegate = self;
    
}

#pragma mark ScoreEarnViewDelegate

- (void)scoreEarnView:(ScoreEarnView *)view actionType:(ScoreEarnViewActionType)type value:(id)value {
    switch (type) {
        case ScoreEarnViewActionTypeLoadData:
        {
            [self loadData:value];
        }
            break;
        case ScoreEarnViewActionTypePlant:
        {
            [self plant:value];
        }
            break;
        case ScoreEarnViewActionTypeExchange:
        {
            [self exchange:value];
        }
            break;
        case ScoreEarnViewActionTypeOrderDetail:
        {
            [self orderDetail:value];
        }
            break;
        case ScoreEarnViewActionTypeContact:
        {
            [self contact:value];
        }
            break;
        case ScoreEarnViewActionTypeComment:
        {
            [self comment:value];
        }
            break;
        case ScoreEarnViewActionTypeSegue:
        {
            [self segue:value];
        }
            break;
        default:
            break;
    }
}

- (void)loadData:(id)value {
    if (![value respondsToSelector:@selector(boolValue)]) {
        return;
    }
    BOOL refresh = [value boolValue];
    
    if (refresh) {
        [self loadBase:refresh];
    }else{
        [self loadList:refresh];
    }
}

- (void)loadBase:(BOOL)refresh {
    [Request startWithName:@"GET_USER_RADISH_SCORE_INFO" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ScoreUserInfoData *data = [ScoreUserInfoModel modelWithDictionary:dic].data;
        if (data) {
            [self loadBaseSuccess:data refresh:refresh];
        }else{
            [self loadBaseFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadBaseFailure:error];
    }];
}

- (void)loadBaseSuccess:(ScoreUserInfoData *)data refresh:(BOOL)refresh {
    self.userInfoData = data;
    self.earnView.userInfoData = data;
    [self loadList:refresh];
}

- (void)loadBaseFailure:(NSError *)error {
    NSString *errMsg = @"获取用户积分信息失败！";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
    [self back];
}

- (void)loadList:(BOOL)refresh {
    if (self.earnView.isLoadProducts) {//获取精选
        self.page_products = refresh?1:++self.page_products;
        NSDictionary *params = @{@"page":@(self.page_products),
                                 @"pageCount":@(TCPAGECOUNT)};
        [Request startWithName:@"GET_MEMBER_PRODUCTS" param:params progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            ScoreProductData *data = [ScoreProductModel modelWithDictionary:dic].data;
            if (refresh || !self.earnView.productData) {
                self.earnView.productData = data;
            }else{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.earnView.productData.products];
                [ary addObjectsFromArray:data.products];
                self.earnView.productData.products = [NSArray arrayWithArray:ary];
            }
            [self.earnView dealWithUI:data.products.count isComment:NO];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self.earnView dealWithUI:0 isComment:NO];
        }];
    }else{//获取评论订单列表
        self.page_comment = refresh?1:++self.page_comment;
        NSDictionary *param = @{@"page":@(self.page_comment),
                                @"pageCount":@(TCPAGECOUNT)};
        [Request startWithName:@"GET_USER_SCORE_ORDERS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            NSArray<ScoreOrderItem *> *data = [ScoreOrderModel modelWithDictionary:dic].data;
            if (refresh) {
                self.earnView.orderItems = [NSArray arrayWithArray:data];
            }else{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.earnView.orderItems];
                [ary addObjectsFromArray:data];
                self.earnView.orderItems = [NSArray arrayWithArray:ary];
            }
            [self.earnView dealWithUI:data.count isComment:YES];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self.earnView dealWithUI:0 isComment:YES];
        }];
    }
}

#pragma mark plant
- (void)plant:(id)value {
    NSString *url = self.userInfoData.radishShopUrl;
    if ([url isNotNull]) {
        WebViewController *controller = [[WebViewController alloc] init];
        controller.urlString = url;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        RadishMallViewController *controller = [[RadishMallViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark exchange
- (void)exchange:(id)value {
    ScoreExchangeViewController *controller = [[ScoreExchangeViewController alloc] initWithNibName:@"ScoreExchangeViewController" bundle:nil];
    controller.userInfoData = self.userInfoData;
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:NO completion:nil];
}

#pragma mark ScoreExchangeViewControllerDelegate

- (void)scoreExchangeViewControllerDidExchangeSuccess:(ScoreExchangeViewController *)controller {
    [self reloadScore];
}

- (void)reloadScore {
    [Request startWithName:@"GET_USER_RADISH_SCORE_INFO" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ScoreUserInfoData *data = [ScoreUserInfoModel modelWithDictionary:dic].data;
        if (data) {
            self.userInfoData = data;
            self.earnView.userInfoData = data;
            [self.earnView reloadData];
        }
    } failure:nil];
}

#pragma mark orderDetail
- (void)orderDetail:(id)value {
    if (![value isKindOfClass:[ScoreOrderItem class]]) {
        return;
    }
    ScoreOrderItem *order = value;
    NSString *orderNo = order.orderNo;
    switch (order.orderKind) {
        case OrderKindNormal:
        {
            if (![orderNo isNotNull]) return;
            SegueModel *segueModel = [SegueModel modelWithDestination:SegueDestinationOrderDetail paramRawData:@{@"sid":orderNo}];
            [SegueMaster makeSegueWithModel:segueModel fromController:self];
        }
            break;
        case OrderKindFlash:
        {
            if (![orderNo isNotNull]) return;
            FlashServiceOrderDetailViewController *controller = [[FlashServiceOrderDetailViewController alloc] init];
            controller.orderId = orderNo;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case OrderKindRadish:
        {
            if (![orderNo isNotNull]) return;
            SegueModel *segueModel = [SegueModel modelWithDestination:SegueDestinationOrderRadishDetail paramRawData:@{@"sid":orderNo}];
            [SegueMaster makeSegueWithModel:segueModel fromController:self];
        }
            break;
        case OrderKindTicket:
        {
            if (![orderNo isNotNull]) return;
            SegueModel *segueModel = [SegueModel modelWithDestination:SegueDestinationOrderTicketDetail paramRawData:@{@"sid":orderNo}];
            [SegueMaster makeSegueWithModel:segueModel fromController:self];
        }
            break;
        case OrderKindFree:
        {
            if (![orderNo isNotNull]) return;
            SegueModel *segueModel = [SegueModel modelWithDestination:SegueDestinationOrderFreeDetail paramRawData:@{@"sid":orderNo}];
            [SegueMaster makeSegueWithModel:segueModel fromController:self];
        }
            break;
        case OrderKindFight:
        {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            if ([order.productNo isNotNull]) {
                [param setObject:order.productNo forKey:@"pid"];
            }
            if ([order.openGroupId isNotNull]) {
                [param setObject:order.openGroupId forKey:@"gid"];
            }
            SegueModel *segueModel = [SegueModel modelWithDestination:SegueDestinationOrderWholesaleDetail paramRawData:param];
            [SegueMaster makeSegueWithModel:segueModel fromController:self];
        }
            break;
        default:
            break;
    }
}

#pragma mark contact
- (void)contact:(id)value {
    if (![value isKindOfClass:[ScoreOrderItem class]]) {
        return;
    }
    ScoreOrderItem *order = value;
    NSArray *numbers = order.phones;
    if (numbers.count == 1) {
        NSString *telString = [NSString stringWithFormat:@"telprompt://%@",numbers.firstObject];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
    } else {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择需要拨打的号码" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSString *phoneNumber in numbers) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:phoneNumber style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *telString = [NSString stringWithFormat:@"telprompt://%@", phoneNumber];
                NSLog(@"%@", [NSURL URLWithString:telString]);
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
            }];
            [controller addAction:action];
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark comment
- (void)comment:(id)value {
    if (![value isKindOfClass:[ScoreOrderItem class]]) {
        return;
    }
    ScoreOrderItem *order = value;
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromScoreOrderItem:order]];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
    self.commentOrder = order;
}

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    NSMutableArray *ary = [NSMutableArray array];
    [self.earnView.orderItems enumerateObjectsUsingBlock:^(ScoreOrderItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj.orderNo isEqualToString:self.commentOrder.orderNo]) {
            if(obj) [ary addObject:obj];
        }
    }];
    self.earnView.orderItems = [NSArray arrayWithArray:ary];
    [self.earnView reloadData];
    
    [self reloadScore];
}

#pragma mark segue
- (void)segue:(id)value {
    [SegueMaster makeSegueWithModel:value fromController:self];
}

@end
