//
//  ProductDetailGetCouponListViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailGetCouponListViewController.h"
#import "ProductDetailGetCouponCell.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "CouponUsableServiceViewController.h"
#import "TabBarController.h"
#import "ProductDetailGetCouponModel.h"

static NSString *const ID = @"ProductDetailGetCouponCell";
static CGFloat const kAnimateDuration =  0.2;

@interface ProductDetailGetCouponListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentConstraintB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentConstraintH;

@end

@implementation ProductDetailGetCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductDetailGetCouponCell" bundle:nil] forCellReuseIdentifier:ID];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
}

- (IBAction)close:(UIButton *)sender {
    [self hide];
}

- (void)show {
    self.contentConstraintB.constant = - self.contentConstraintH.constant;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.contentConstraintB.constant = self.keyboardHeight;
        [self.view layoutIfNeeded];
    }];
}

- (void)hide {
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.view.backgroundColor = [UIColor clearColor];
        self.contentConstraintB.constant = - self.contentConstraintH.constant;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.coupons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailGetCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.item = self.coupons[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ProductDetailGetCouponItem *item = self.coupons[indexPath.row];
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        if (!item.isProvider) {
            if (![item.batchNo isNotNull]) {
                [[iToast makeText:@"该优惠券编号为空"] show];
                return;
            }
            NSDictionary *param = @{@"batchid":item.batchNo};
            [TCProgressHUD showSVP];
            [Request startWithName:@"COUPON_FETCH" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
                [TCProgressHUD dismissSVP];
                [self load];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [TCProgressHUD dismissSVP];
                [[iToast makeText:@"领取优惠券失败，请稍后再试~"] show];
            }];
        }else{
            if (item.canRedirect) {
                CouponUsableServiceViewController *controller = [[CouponUsableServiceViewController alloc] initWithCouponBatchIdentifier:item.batchNo];
                UINavigationController *navi = [TabBarController shareTabBarController].selectedViewController;
                [navi pushViewController:controller animated:YES];
                [self hide];
            }else{
                [[iToast makeText:@"您已领取该优惠券，不能重复领取~"]show];
            }
        }
    }];
}


- (void)load {
    NSDictionary *param = @{@"productId":self.productId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_PRODUCT_DETAIL_USER_COUPON" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ProductDetailGetCouponModel *model = [ProductDetailGetCouponModel modelWithDictionary:dic];
        self.coupons = model.data;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
    }];
}

@end
