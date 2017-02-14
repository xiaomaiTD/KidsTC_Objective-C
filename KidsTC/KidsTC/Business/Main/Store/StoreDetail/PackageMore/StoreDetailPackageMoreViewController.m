//
//  StoreDetailPackageMoreViewController.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "StoreDetailPackageMoreViewController.h"
#import "SegueMaster.h"
#import "StoreDetailPackageMoreCell.h"

static NSString *const PackageMoreCellID = @"StoreDetailPackageMoreCell";

@interface StoreDetailPackageMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StoreDetailPackageMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"活动套餐";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreDetailPackageMoreCell" bundle:nil] forCellReuseIdentifier:PackageMoreCellID];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreDetailPackageMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:PackageMoreCellID];
    NSUInteger row = indexPath.row;
    if (row<self.products.count) {
        TCStoreDetailProductPackageItem *product = self.products[row];
        cell.product = product;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = indexPath.row;
    if (row<self.products.count) {
        TCStoreDetailProductPackageItem *product = self.products[row];
        [SegueMaster makeSegueWithModel:product.segueModel fromController:self];
    }
}


@end
