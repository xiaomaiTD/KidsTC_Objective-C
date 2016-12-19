//
//  ProductDetailFreeApplySelectPlaceViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplySelectPlaceViewController.h"
#import "Colours.h"
#import "iToast.h"

#import "ProductDetailFreeApplySelectPlaceCell.h"

static NSString *const CellID = @"ProductDetailFreeApplySelectPlaceCell";

@interface ProductDetailFreeApplySelectPlaceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation ProductDetailFreeApplySelectPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_places.count<1) {
        [[iToast makeText:@"地址列表为空"] show];
        [self back];
        return;
    }
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"选择地址";
    
    self.tableView.estimatedRowHeight = 80;
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductDetailFreeApplySelectPlaceCell" bundle:nil] forCellReuseIdentifier:CellID];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailFreeApplySelectPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    NSInteger row = indexPath.row;
    if (row<self.places.count) {
        cell.place = self.places[row];
        cell.nameL.textColor = (row == self.currentIndex)?COLOR_PINK:[UIColor colorFromHexString:@"222222"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    if (row<self.places.count) {
        if (self.actionBlock) self.actionBlock(row);
    }
    [self back];
}


@end
