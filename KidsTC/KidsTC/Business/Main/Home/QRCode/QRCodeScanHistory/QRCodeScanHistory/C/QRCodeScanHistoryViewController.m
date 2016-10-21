//
//  QRCodeScanHistoryViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "QRCodeScanHistoryViewController.h"
#import "QRCodeScanHistoryTableViewCell.h"
#import "QRCodeScanHistoryDataManager.h"
#import "UIBarButtonItem+Category.h"
#import "WebViewController.h"
#import "QRCodeScanTextViewController.h"

static NSString *const kQRCodeScanHistoryTableViewCellID = @"QRCodeScanHistoryTableViewCell";

@interface QRCodeScanHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) NSMutableArray<QRCodeScanHistoryItem *> *items;
@end

@implementation QRCodeScanHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"扫描历史";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"清空" postion:UIBarButtonPositionRight target:self action:@selector(rightBarButtonItemAction)];
    
    self.items = [QRCodeScanHistoryDataManager shareQRCodeScanHistoryDataManager].items;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorWithRed:0.988 green:0.981 blue:0.972 alpha:1];
    tableView.estimatedRowHeight = 44;
    [tableView registerNib:[UINib nibWithNibName:@"QRCodeScanHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:kQRCodeScanHistoryTableViewCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)rightBarButtonItemAction {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"要清空全部扫描历史吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"还是算了" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *clean = [UIAlertAction actionWithTitle:@"马上清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[QRCodeScanHistoryDataManager shareQRCodeScanHistoryDataManager] cleanUp];
        [self.tableView reloadData];
    }];
    [controller addAction:clean];
    [controller addAction:cancle];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QRCodeScanHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kQRCodeScanHistoryTableViewCellID];
    cell.item = self.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    QRCodeScanHistoryItem *item = self.items[indexPath.row];
    switch (item.type) {
        case QRCodeScanHistoryItemTypeQRCode:
        {
            
        }
            break;
        case QRCodeScanHistoryItemTypeBarCode:
        {
            
        }
            break;
        case QRCodeScanHistoryItemTypeProduct:
        {
            
        }
            break;
    }
    NSString *string = item.subTitle;
    if ([string hasPrefix:@"http"]) {
        string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([string containsString:@"kidstc.com"]) {
            WebViewController *controller = [[WebViewController alloc] init];
            controller.urlString = string;
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
        }
    }else{
        QRCodeScanTextViewController *controller = [[QRCodeScanTextViewController alloc] initWithNibName:@"QRCodeScanTextViewController" bundle:nil];
        controller.text = item.subTitle;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
        {
            if (self.items.count>indexPath.row) {
                [[QRCodeScanHistoryDataManager shareQRCodeScanHistoryDataManager] remove:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
        }
            break;
        default:
            break;
    }
}



@end
