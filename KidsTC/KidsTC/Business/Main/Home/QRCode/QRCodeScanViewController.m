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

@interface QRCodeScanViewController ()

@end

@implementation QRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"二维码/条形码";
    self.naviColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"newbarcode_historyempty_icon" highImageName:@"newbarcode_historyempty_icon" postion:UIBarButtonPositionRight target:self action:@selector(rightBarButtonItemAction)];
    
    QRCodeView *view = [[QRCodeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:view];
    
    [view startScan];
}

- (void)rightBarButtonItemAction {
    
}


@end
