//
//  ResetPasswordViewController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "ATCountDown.h"
#import "NSString+Category.h"

@interface ResetPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTf;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *showPasswodBtn;
@property (weak, nonatomic) IBOutlet UIButton *makeSureBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HlineOneConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HlineTwoConstraintHeight;
@property (nonatomic, strong) NSString *codeKey;
@property (nonatomic, strong) ATCountDown *countDown;
@end

@implementation ResetPasswordViewController

- (NSString *)codeKey{
    if (!_codeKey) {
        _codeKey = @"";
    }
    return _codeKey;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10905;
    
    [self initui];
}

- (void)initui{
    
    self.navigationItem.title = @"重置密码";
    
    self.makeSureBtn.backgroundColor = COLOR_PINK;
    
    CALayer *layer = self.getSecurityCodeBtn.layer;
    layer.borderColor = COLOR_PINK.CGColor;
    layer.borderWidth = LINE_H;
    layer.cornerRadius = 2;
    layer.masksToBounds = YES;
    [self.getSecurityCodeBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    [self.getSecurityCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    self.getSecurityCodeBtn.adjustsImageWhenHighlighted = NO;
    self.HlineOneConstraintHeight.constant = LINE_H;
    self.HlineTwoConstraintHeight.constant = LINE_H;
    
    NSString *phone = [User shareUser].phone;
    if ([phone isNotNull]) {
        self.userNameTf.text = phone;
        self.userNameTf.userInteractionEnabled = NO;
    }
}

#pragma mark - getSecurityCode

- (IBAction)getSecurityCode:(UIButton *)sender {
    NSString *phone = self.userNameTf.text;
    if (![self validatePhone:phone]) return;
    self.codeKey = [NSString generateSMSCodeKey];
    NSDictionary *param = @{@"mobile":phone,
                            @"codeKey":self.codeKey,
                            @"smsType":@"0",
                            @"validateType":@"2"};
    [TCProgressHUD showSVP];
    [Request startWithName:@"TOOL_SEND_REGISTER_SMS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self getSecurityCodeSuccess];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self getSecurityCodeFailure:error];
    }];
}

- (void)getSecurityCodeSuccess{
    [[iToast makeText:@"验证码请求成功"] show];
    self.countDown = [[ATCountDown alloc]initWithLeftTimeInterval:60];
    [self.countDown startCountDownWithCurrentTimeLeft:^(NSTimeInterval currentTimeLeft) {
        NSString *title = [NSString stringWithFormat:@"重新获取(%.f)", currentTimeLeft];
        [self setGetCodeButtonEnableState:NO title:title];
    } completion:^{
        [self setGetCodeButtonEnableState:YES title:@"获取验证码"];
    }];
}

- (void)getSecurityCodeFailure:(NSError *)error {
    NSString *errMsg = @"";
    if (error.userInfo) errMsg = error.userInfo[@"data"];
    if (errMsg.length==0) errMsg = @"获取验证码失败";
    [[iToast makeText:errMsg] show];
}

- (void)setGetCodeButtonEnableState:(BOOL)enabled title:(NSString *)title {
    
    UIButton *btn = self.getSecurityCodeBtn;
    btn.enabled = enabled;
    
    CALayer *btnLayer = btn.layer;
    if (enabled) {
        btnLayer.borderColor = COLOR_PINK.CGColor;
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        btnLayer.borderColor = COLOR_LINE.CGColor;
        [btn setTitle:title forState:UIControlStateDisabled];
    }
}

#pragma mark - 重置密码

- (IBAction)makeSure:(UIButton *)sender {
    NSString *phone = self.userNameTf.text;
    NSString *securityCode = self.securityCodeTf.text;
    NSString *password = self.passwordTf.text;
    if (![self validatePhone:phone securityCode:securityCode password:password]) return;
    NSDictionary *param = @{@"mobile":phone,
                            @"passWord":password,
                            @"code":securityCode,
                            @"codeKey":self.codeKey};
    [TCProgressHUD showSVP];
    [Request startWithName:@"USER_FIND_PASSWORD" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self resetPasswordSucceed];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self resetPasswordFailedWithError:error];
    }];
}

- (void)resetPasswordSucceed{
    [[iToast makeText:@"重置密码成功"] show];
    [[User shareUser] logoutManually:YES withSuccess:nil failure:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)resetPasswordFailedWithError:(NSError *)error {
    NSString *errMsg = @"";
    if (error.userInfo) errMsg = error.userInfo[@"data"];
    if (errMsg.length == 0) errMsg = @"重置密码失败";
    [[iToast makeText:errMsg] show];
}

#pragma mark - showPasswod

- (IBAction)showPasswod:(UIButton *)sender {
    NSString *password = self.passwordTf.text;
    self.showPasswodBtn.selected = !self.showPasswodBtn.selected;
    [self.passwordTf setSecureTextEntry:!self.showPasswodBtn.selected];
    self.passwordTf.text = nil;
    self.passwordTf.text = password;
}

#pragma mark - helpers

- (BOOL)validatePhone:(NSString *)phone
         securityCode:(NSString *)securityCode
             password:(NSString *)password
{
    if (phone.length==0) {
        [[iToast makeText:@"请输入手机号"] show];
        return NO;
    }
    if (securityCode.length==0) {
        [[iToast makeText:@"请输入验证码"] show];
        return NO;
    }
    if (password.length==0) {
        [[iToast makeText:@"请输入密码"] show];
        return NO;
    }
    if (password.length<6 || password.length>20) {
        [[iToast makeText:@"请输入6-20位至少包含数字和字母的密码"] show];
        return NO;
    }
    return YES;
}

- (BOOL)validatePhone:(NSString *)phone{
    if (phone.length==0) {
        [[iToast makeText:@"请输入手机号"] show];
        return NO;
    }
    return YES;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.passwordTf) self.showPasswodBtn.hidden = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.showPasswodBtn.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
