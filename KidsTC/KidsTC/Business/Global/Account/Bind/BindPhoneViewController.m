//
//  BindPhoneViewController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/19.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "NSString+Category.h"
#import "GHeader.h"
#import "ThirdPartyLoginService.h"
#import "User.h"
#import "ATCountDown.h"
@interface BindPhoneViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTf;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTf;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HlineConstraintHeight;

@property (nonatomic, strong) NSString *codeKey;
@property (nonatomic, strong) ATCountDown *countDown;
@end

@implementation BindPhoneViewController

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
    
    self.navigationItem.title = @"请先绑定手机";
    
    self.bindBtn.backgroundColor = COLOR_PINK;
    
    CALayer *layer = self.getSecurityCodeBtn.layer;
    layer.borderColor = COLOR_PINK.CGColor;
    layer.borderWidth = LINE_H;
    layer.cornerRadius = 2;
    layer.masksToBounds = YES;
    [self.getSecurityCodeBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    [self.getSecurityCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    self.HlineConstraintHeight.constant = LINE_H;
}

- (void)back{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"不绑定手机将无法正常登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelBind = [UIAlertAction actionWithTitle:@"暂不绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *continueBind = [UIAlertAction actionWithTitle:@"继续绑定" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:cancelBind];
    [controller addAction:continueBind];
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - getSecurityCode

- (IBAction)getSecurityCode:(UIButton *)sender {
    
    NSString *phone = self.userNameTf.text;
    if (![self validatePhone:phone]) return;
    
    self.codeKey = [NSString generateSMSCodeKey];
    NSDictionary *param = @{@"mobile":phone,
                            @"codeKey":self.codeKey,
                            @"smsType":@"0"};
    [TCProgressHUD showSVP];
    [Request startWithName:@"TOOL_SEND_SMS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        TCLog(@"获取验证码成功");
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

#pragma mark - bind

- (IBAction)bind:(UIButton *)sender {
    NSString *phone = self.userNameTf.text;
    NSString *securityCode = self.securityCodeTf.text;
    
    if (![self validatePhone:phone securityCode:securityCode]) return;
    
    ThirdPartyLoginType loginType = [[ThirdPartyLoginService sharedService] currentLoginType];
    NSString *openId = [[ThirdPartyLoginService sharedService] currentOpenId];
    NSString *accessToken = [[ThirdPartyLoginService sharedService] currentAccessToken];
    
    NSDictionary *param = @{@"mobile":phone,
                            @"code":securityCode,
                            @"codeKey":self.codeKey,
                            @"thirdType":@(loginType),
                            @"openId":openId,
                            @"accessToken":accessToken};
    [TCProgressHUD showSVP];
    [Request startWithName:@"THIRD_USER_PHONE_REGISTER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self bindPhoneSucceedWithRespData:dic];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self bindPhoneFailureWithError:error];
    }];
    
}

- (void)bindPhoneSucceedWithRespData:(NSDictionary *)data {
    NSDictionary *userData = [data objectForKey:@"data"];
    NSString *uid = nil;
    if (userData && [userData isKindOfClass:[NSDictionary class]]) {
        uid = [NSString stringWithFormat:@"%@", [userData objectForKey:@"uid"]];
        NSString *skey = [userData objectForKey:@"skey"];
        if (uid.length>0 && skey.length>0) {
            [[iToast makeText:@"绑定成功"] show];
            [[User shareUser] updateUid:uid skey:skey];
        }
    } else {
        [[iToast makeText:@"获取用户信息失败, 请重新登录"] show];
    }
    if ([self.delegate respondsToSelector:@selector(didFinishedBindPoneActionWithUid:)]) {
        [self.delegate didFinishedBindPoneActionWithUid:uid];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)bindPhoneFailureWithError:(NSError *)error {
    NSString *errMsg = [error.userInfo objectForKey:@"data"];
    if ([errMsg length] == 0) errMsg = @"绑定失败";
    [[iToast makeText:errMsg] show];
}

#pragma mark - helpers

- (BOOL)validatePhone:(NSString *)phone
         securityCode:(NSString *)securityCode
{
    if (phone.length==0) {
        [[iToast makeText:@"请输入手机号"] show];
        return NO;
    }
    if (securityCode.length==0) {
        [[iToast makeText:@"请输入验证码"] show];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return NO;
}
@end
