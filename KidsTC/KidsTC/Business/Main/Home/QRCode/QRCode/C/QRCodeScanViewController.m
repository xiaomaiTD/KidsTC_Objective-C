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
#import "QRCodeScanTextViewController.h"
#import "GHeader.h"
#import "QRCodeScanBarCodeModel.h"
#import "SegueMaster.h"


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
            [self addHistoryLocal:dic];
            [self segue:dic[@"string"]];
        }
            break;
    }
}

- (void)addHistoryLocal:(NSDictionary *)dic {
    NSString *string = [NSString stringWithFormat:@"%@",dic[@"string"]];
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

- (void)segue:(NSString *)string {
    
    if ([string hasPrefix:@"http"]) {
        
        NSDictionary *param = @{@"scanChannel":@"1",
                                @"scanContent":string};
        [Request startWithName:@"UPLOAD_SCAN_HISTORY" param:param progress:nil success:nil failure:nil];
        
        string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([string containsString:@"kidstc.com"]) {
            WebViewController *controller = [[WebViewController alloc] init];
            controller.urlString = string;
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"可能存在风险，是否打开此链接？" message:string preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.qrCodeView startScan];
            }];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"打开链接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.qrCodeView startScan];
                [self.navigationController popViewControllerAnimated:YES];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
            }];
            [controller addAction:cancle];
            [controller addAction:sure];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }else{
        
        NSDictionary *param = @{@"scanChannel":@"1",
                                @"scanContent":string};
        [TCProgressHUD showSVP];
        [Request startWithName:@"SCAN_BAR_CODE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            [TCProgressHUD dismissSVP];
            QRCodeScanBarCodeModel *model = [QRCodeScanBarCodeModel modelWithDictionary:dic];
            [SegueMaster makeSegueWithModel:model.data.segueModel fromController:self];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [TCProgressHUD dismissSVP];
            [[iToast makeText:@"查询失败"] show];
            QRCodeScanTextViewController *controller = [[QRCodeScanTextViewController alloc] initWithNibName:@"QRCodeScanTextViewController" bundle:nil];
            controller.text = string;
            [self.navigationController pushViewController:controller animated:YES];
        }];
    }
}

@end
