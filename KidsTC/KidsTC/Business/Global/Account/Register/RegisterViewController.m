//
//  RegisterViewController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "RegisterViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "ATCountDown.h"
#import "RegisterModel.h"
#import "User.h"
#import "WebViewController.h"
#import "NSString+Category.h"

#define ProtocalLink (@"http://m.kidstc.com/tools/reg_desc")
static NSString *const ProtocolLink = @"http://m.kidstc.com/tools/reg_desc";

@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTf;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *showPasswodBtn;
@property (weak, nonatomic) IBOutlet UIButton *makeSureBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIButton *readProtocolBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineOneConstraintHeigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineTwoConstraintHeigh;

@property (nonatomic, strong) NSString *codeKey;
@property (nonatomic, strong) ATCountDown *countDown;
@end

@implementation RegisterViewController

- (NSString *)codeKey{
    if (!_codeKey) {
        _codeKey = @"";
    }
    return _codeKey;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initui];
}

- (void)initui{
    
    self.navigationItem.title = @"注册";
    
    self.makeSureBtn.backgroundColor = COLOR_PINK;
    [self.readProtocolBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    
    CALayer *layer = self.getSecurityCodeBtn.layer;
    layer.borderColor = COLOR_PINK.CGColor;
    layer.borderWidth = LINE_H;
    layer.cornerRadius = 2;
    layer.masksToBounds = YES;
    [self.getSecurityCodeBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    [self.getSecurityCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    self.HLineOneConstraintHeigh.constant = LINE_H;
    self.HLineTwoConstraintHeigh.constant = LINE_H;
    
    self.checkBtn.selected = YES;
}

#pragma mark - actions

#pragma mark - getSecurityCode

- (IBAction)getSecurityCode {
    NSString *phone = self.userNameTf.text;
    if (![self validatePhone:phone]) return;
    self.codeKey = [NSString generateSMSCodeKey];
    NSDictionary *param = @{@"mobile":phone,
                            @"codeKey":self.codeKey,
                            @"smsType":@"0",
                            @"validateType":@"1"};
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

#pragma mark - register

- (IBAction)makeSure:(UIButton *)sender {
    if (!self.checkBtn.selected) {
        [[iToast makeText:@"请先确认已阅读《童成网用户协议》"] show];
        return;
    }
    NSString *phone = self.userNameTf.text;
    NSString *securityCode = self.securityCodeTf.text;
    NSString *password = self.passwordTf.text;
    if (![self validatePhone:phone securityCode:securityCode password:password]) return;
    NSDictionary *param = @{@"mobile":phone,
                            @"code":securityCode,
                            @"codeKey":self.codeKey,
                            @"passWord":password};
    [TCProgressHUD showSVP];
    [Request startWithName:@"USER_REGISTER_LOGIN" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        RegisterModel *model = [RegisterModel modelWithDictionary:dic];
        [self registerSucceedWithModel:model];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self registerFailedWithError:error];
    }];
}

- (void)registerSucceedWithModel:(RegisterModel *)model{
    NSString *uid = model.data.uid;
    NSString *skey = model.data.skey;
    if ([uid isNotNull] && [skey isNotNull]) {
        [[User shareUser] updateUid:uid skey:skey];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self registerFailedWithError:nil];
    }
}

- (void)registerFailedWithError:(NSError *)error{
    NSString *errMsg = @"";
    if (error.userInfo) {
        errMsg = [error.userInfo objectForKey:@"data"];
    }
    if (![errMsg isKindOfClass:[NSString class]] || [errMsg length] == 0) {
        errMsg = @"注册失败";
    }
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

- (IBAction)check:(UIButton *)sender {
    self.checkBtn.selected = !self.checkBtn.selected;
}

- (IBAction)readProtocol:(UIButton *)sender {
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.urlString = ProtocalLink;
    [self.navigationController pushViewController:webVC animated:YES];}

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

@end
