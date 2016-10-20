//
//  QRCodeScanViewController.m
//  QRCodeDemo
//
//  Created by 詹平 on 2016/10/2.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import "QRCodeView.h"
#import "UIBarButtonItem+Category.h"
#import "WebViewController.h"
#import "QRCodeScanHistoryDataManager.h"
#import "QRCodeScanHistoryViewController.h"

@interface QRCodeScanViewController ()<QRCodeViewDelegate>
@property (nonatomic, strong) QRCodeView *qrCodeView;
@end

@implementation QRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"二维码/条形码";
    self.naviColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"newbarcode_historyempty_icon" highImageName:@"newbarcode_historyempty_icon" postion:UIBarButtonPositionRight target:self action:@selector(rightBarButtonItemAction)];
    
    QRCodeView *qrCodeView = [[QRCodeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    qrCodeView.delegate = self;
    [self.view addSubview:qrCodeView];
    self.qrCodeView = qrCodeView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.qrCodeView startScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.qrCodeView stopScan];
}

- (void)rightBarButtonItemAction {
    QRCodeScanHistoryViewController *controller = [[QRCodeScanHistoryViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - QRCodeViewDelegate

- (void)qrCodeView:(QRCodeView *)view actionType:(QRCodeViewActionType)type value:(id)value {
    
    switch (type) {
        case QRCodeViewActionTypeHasValiteValue:
        {
            NSDictionary *dic = value;
            [self addHistory:dic];
            NSString *string = dic[@"string"];
            [self.navigationController popViewControllerAnimated:YES];
            if ([string hasPrefix:@"http"]) {
                if ([string containsString:@"kidstc.com"]) {
                    WebViewController *controller = [[WebViewController alloc] init];
                    controller.urlString = string;
                    [self.navigationController pushViewController:controller animated:YES];
                }else{
                    NSURL *url = [NSURL URLWithString:string];
                    [[UIApplication sharedApplication] openURL:url];
                }
            }else{
                
            }
        }
            break;
    }
}

- (void)addHistory:(NSDictionary *)dic {
    NSString *string = dic[@"string"];
    QRCodeScanHistoryItem *item = [QRCodeScanHistoryItem new];
    if ([string hasPrefix:@"http"]) {//链接
        item.title = @"链接";
        item.type = QRCodeScanHistoryItemTypeQRCode;
    }else{
        item.title = @"文本";
        item.type = QRCodeScanHistoryItemTypeBarCode;
    }
    item.subTitle = string;
    item.time = [NSDate date].timeIntervalSince1970;
    [[QRCodeScanHistoryDataManager shareQRCodeScanHistoryDataManager] addItem:item];
}


@end
