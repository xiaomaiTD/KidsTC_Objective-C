//
//  StoreDetailCouponMoreViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "StoreDetailCouponMoreViewController.h"
#import "StoreDetailCouponMoreCell.h"
#import "SegueMaster.h"
#import "GHeader.h"
#import "NSString+Category.h"

static NSString *const CouponMoreCellID = @"StoreDetailCouponMoreCell";
@interface StoreDetailCouponMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL hasChangeCouponStatus;
@end

@implementation StoreDetailCouponMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreDetailCouponMoreCell" bundle:nil] forCellReuseIdentifier:CouponMoreCellID];
    [self.tableView reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.hasChangeCouponStatus) {
        if ([self.delegate respondsToSelector:@selector(couponStatusHasChangeStoreDetailCouponMoreViewController:)]) {
            [self.delegate couponStatusHasChangeStoreDetailCouponMoreViewController:self];
        }
    }
    [self back];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.coupons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreDetailCouponMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CouponMoreCellID];
    NSInteger row = indexPath.row;
    if (row<self.coupons.count) {
        TCStoreDetailCoupon *coupon = self.coupons[row];
        cell.coupon = coupon;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    if (row<self.coupons.count) {
        TCStoreDetailCoupon *coupon = self.coupons[row];
        if (coupon.isProvider) {
            [[iToast makeText:@"不可重复领取哦~"] show];
            return;
        }
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
                self.hasChangeCouponStatus = YES;
                coupon.isProvider = YES;
                [tableView reloadData];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [TCProgressHUD dismissSVP];
                NSString *errMsg = @"领取优惠券失败，请稍后再试~";
                NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
                if ([text isNotNull]) errMsg = text;
                [[iToast makeText:errMsg] show];
            }];
        }];
    }
}

@end
