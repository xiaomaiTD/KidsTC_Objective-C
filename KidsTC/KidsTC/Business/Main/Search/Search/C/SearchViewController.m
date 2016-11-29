//
//  SearchViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIBarButtonItem+Category.h"
#import "Colours.h"

#import "SpeekViewController.h"
#import "SearchResultViewController.h"

@interface SearchViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *tf;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    
    [self buildNavigationBar];
    
    [self setupTf];
}

- (void)buildNavigationBar{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"搜索" postion:UIBarButtonPositionRight target:self action:@selector(search) andGetButton:^(UIButton *btn) {
        [btn setTitleColor:[UIColor colorFromHexString:@"5B5B5B"] forState:UIControlStateNormal];
    }];
}

- (void)search {
    SearchResultViewController *controller = [[SearchResultViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)setupTf {
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 400, 30)];
    tf.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    tf.font = [UIFont systemFontOfSize:15];
    tf.borderStyle = UITextBorderStyleNone;
    tf.layer.cornerRadius = 4;
    tf.textColor = [UIColor whiteColor];
    tf.layer.masksToBounds = YES;
    tf.delegate = self;
    
    UIButton *leftBtn = [UIButton new];
    leftBtn.showsTouchWhenHighlighted = NO;
    leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [leftBtn setImage:[UIImage imageNamed:@"home_search_wite"] forState:UIControlStateNormal];
    leftBtn.bounds = CGRectMake(0, 0, 30, 30);
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    tf.leftView = leftBtn;
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *rightBtn = [UIButton new];
    rightBtn.showsTouchWhenHighlighted = NO;
    rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightBtn setImage:[UIImage imageNamed:@"home_siri_wite"] forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 30, 30);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [rightBtn addTarget:self action:@selector(speek) forControlEvents:UIControlEventTouchUpInside];
    tf.rightView = rightBtn;
    tf.rightViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.titleView = tf;
    self.tf = tf;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

- (void)speek {
    [self requestAccess:AVMediaTypeAudio name:@"麦克风" callBack:^{
        SpeekViewController *controller = [[SpeekViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}


- (void)requestAccess:(NSString *)type name:(NSString *)name callBack:(void(^)())callBack {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:type];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:type completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        if(callBack)callBack();
                        TCLog(@"授权成功");
                    }else{
                        TCLog(@"授权失败");
                    }
                });
            }];
        }
            break;
        case AVAuthorizationStatusAuthorized:
        {
            if(callBack)callBack();
        }
            break;
        default:
        {
            [self alertTipWithTarget:self name:name];
        }
            break;
    }
}

- (void)alertTipWithTarget:(UIViewController *)target name:(NSString *)name{
    NSString *prodName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
    NSString *title = [NSString stringWithFormat:@"%@授权",name];
    NSString *message = [NSString stringWithFormat:@"您尚未开启%@APP%@授权，不能使用该功能。请到“设置-%@-%@”中开启",prodName,name,prodName,name];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alert addAction:cancle];
    [alert addAction:sure];
    [target presentViewController:alert animated:YES completion:nil];
}


@end
