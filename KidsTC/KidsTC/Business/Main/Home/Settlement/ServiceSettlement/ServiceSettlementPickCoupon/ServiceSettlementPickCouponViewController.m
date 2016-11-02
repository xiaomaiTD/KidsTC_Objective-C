//
//  ServiceSettlementPickCouponViewController.m
//  KidsTC
//
//  Created by zhanping on 8/13/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementPickCouponViewController.h"
#import "UIBarButtonItem+Category.h"
#import "ServiceSettlementPickCouponViewCell.h"
#import "ServiceSettlementPickCouponViewHeader.h"
#import "WebViewController.h"
#import "NSString+Category.h"

#define ITEM_MARGIN 12
static NSString *const kCouponUseRuleUrlString = @"http://m.kidstc.com/tools/coupon_desc";

@interface ServiceSettlementPickCouponViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) ServiceSettlementCouponItem *selectedCoupon;
@end
static NSString *const ID = @"ServiceSettlementPickCouponViewCellID";
@implementation ServiceSettlementPickCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10502;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.settlementModel.data.count>0) {
        ServiceSettlementDataItem *item = self.settlementModel.data.firstObject;
        if ([item.serveId isNotNull]) {
            [params setValue:item.serveId forKey:@"pid"];
        }
        if ([item.channelId isNotNull]) {
            [params setValue:item.serveId forKey:@"cid"];
        }
    }
    self.trackParams = [NSDictionary dictionaryWithDictionary:params];
    
    self.navigationItem.title = @"选择优惠券";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确定" postion:UIBarButtonPositionRight target:self action:@selector(rightBarButtonItemAction)];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 44.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ITEM_MARGIN)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    ServiceSettlementPickCouponViewHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"ServiceSettlementPickCouponViewHeader" owner:self options:nil]firstObject];
    header.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    header.actionBlock = ^void (){
        [self couponUseQuestion];
    };
    tableView.tableHeaderView = header;
    [tableView registerNib:[UINib nibWithNibName:@"ServiceSettlementPickCouponViewCell" bundle:nil] forCellReuseIdentifier:ID];

    [self setSelectedCoupon:self.settlementModel.data.firstObject.maxCoupon model:self.settlementModel];
}

- (void)rightBarButtonItemAction {
    if (self.pickCouponBlock) self.pickCouponBlock(self.selectedCoupon);
    [self back];
}

- (void)couponUseQuestion {
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = kCouponUseRuleUrlString;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *coupons = self.settlementModel.data.firstObject.coupon;
    return coupons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceSettlementPickCouponViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSArray *coupons = self.settlementModel.data.firstObject.coupon;
    cell.item = coupons[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceSettlementCouponItem *coupon = self.settlementModel.data.firstObject.coupon[indexPath.row];
    [self setSelectedCoupon:coupon model:self.settlementModel];
    [tableView reloadData];
}

#pragma mark - helpers

- (void)setSelectedCoupon:(ServiceSettlementCouponItem *)coupon model:(ServiceSettlementModel *)model {
    [model.data.firstObject.coupon enumerateObjectsUsingBlock:^(ServiceSettlementCouponItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.code == coupon.code) {
            obj.selected = !obj.selected;
            self.selectedCoupon = obj.selected?obj:nil;
        }else{
            obj.selected = NO;
        }
    }];
}
@end
