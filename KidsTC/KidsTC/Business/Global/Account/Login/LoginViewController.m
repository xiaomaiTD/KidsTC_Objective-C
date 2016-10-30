//
//  LoginViewController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ResetPasswordViewController.h"
#import "UIBarButtonItem+Category.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "LoginModel.h"
#import "User.h"
#import "UIImage+Category.h"
#import "ThirdPartyLoginService.h"
#import "UIView+Category.h"
#import "BindPhoneViewController.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"

CGFloat const ThirdLoginBtnSize = 40;
CGFloat const ThirdLoginBtnMargin = 30;

@interface LoginViewController ()<UITextFieldDelegate,BindPhoneViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UIButton *showPasswodBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *leftLine;
@property (weak, nonatomic) IBOutlet UIView *rightLine;
@property (weak, nonatomic) IBOutlet UIView *thirdPartIconView;
@property (weak, nonatomic) IBOutlet UIButton *resetPasswordBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineConstraintHeight;
@property (nonatomic, strong) NSMutableArray *btns;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10903;
    
    [self initui];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:COLOR_PINK] forBarMetrics:UIBarMetricsDefault];
}

- (void)initui{
    
    self.navigationItem.title = @"登录";
    
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem itemWithImageName:@"navigation_close" highImageName:@"navigation_close" postion:UIBarButtonPositionLeft target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"注册" postion:UIBarButtonPositionRight target:self action:@selector(gotoRegister)];
    self.leftLine.backgroundColor = COLOR_LINE;
    self.rightLine.backgroundColor = COLOR_LINE;
    self.loginBtn.backgroundColor = COLOR_PINK;
    [self.resetPasswordBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    self.lineConstraintHeight.constant = LINE_H;
 
    NSArray<LoginItemModel *> *items = [self supportedLoginTypes];
    NSMutableArray *btns = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(LoginItemModel *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [self btnWithItem:obj tag:idx];
        [btns addObject:btn];
    }];
    self.btns = btns;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    NSUInteger count = self.btns.count;
    CGFloat superView_w = CGRectGetWidth(self.thirdPartIconView.frame);
    CGFloat left = (superView_w - (count-1)*(ThirdLoginBtnSize+ThirdLoginBtnMargin) - ThirdLoginBtnSize)*0.5;
    CGFloat center_y = CGRectGetHeight(self.thirdPartIconView.frame)*0.5;
    [self.btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat center_x = left + (ThirdLoginBtnSize+ThirdLoginBtnMargin)*idx +ThirdLoginBtnSize*0.5;
        btn.center = CGPointMake(center_x, center_y);
    }];
}

#pragma mark - login

- (IBAction)login:(UIButton *)sender {
    [self.view endEditing:YES];
    NSString *phone = self.userNameTf.text;
    NSString *password = self.passwordTf.text;
    if (![self validatePhone:phone password:password]) return;
    NSString *encodePWD = [password base64EncodedString];
    NSDictionary *param = @{@"account":phone,
                           @"password":encodePWD};
    [TCProgressHUD showSVP];
    [Request startWithName:@"LOGIN_LOGIN" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        LoginModel *model = [LoginModel modelWithDictionary:dic];
        [self loginSucceedWithModel:model];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loginFailedWithError:error];
    }];
}

- (void)loginSucceedWithModel:(LoginModel *)model{
    NSString *uid = model.data.uid;
    NSString *skey = model.data.skey;
    if ([uid isNotNull] && [skey isNotNull]) {
        [self loginSuccessWithUid:uid skey:skey];
    }else{
        [[iToast makeText:@"登录失败"] show];
    }
    NSDictionary *params = @{@"uid":uid,
                             @"type":@(1)};
    [BuryPointManager trackEvent:@"event_result_login" actionId:21501 params:params];
}

- (void)loginFailedWithError:(NSError *)error{
    
    NSString *errMsg = @"";
    if (error.userInfo) errMsg = [error.userInfo objectForKey:@"data"];
    if (error.code == -2008) {
        if (![errMsg isKindOfClass:[NSString class]] || [errMsg length] == 0) {
            errMsg = @"密码尚未设置，请先设置密码";
        }
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:errMsg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *goAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self resetPassword:self.resetPasswordBtn];
        }];
        [controller addAction:cancelAction];
        [controller addAction:goAction];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }
    if (![errMsg isKindOfClass:[NSString class]] || [errMsg length] == 0) {
        errMsg = @"登录失败";
    }
    [[iToast makeText:errMsg] show];
}

#pragma mark - thirdPartLogin

- (void)thirdPartLoginAction:(UIButton *)btn {
    NSArray<LoginItemModel *> *models = self.supportedLoginTypes;
    if (btn.tag>=models.count) return;
    
    LoginItemModel *item = models[btn.tag];
    switch (item.type) {
        case LoginTypeQQ:
        {
            [[ThirdPartyLoginService sharedService] startThirdPartyLoginWithType:ThirdPartyLoginTypeQQ succeed:^(NSDictionary *respData) {
                [self handleThirdPartyLoginSucceed:respData type:ThirdPartyLoginTypeQQ];
            } failure:^(NSError *error) {
                [self handleThirdPartyLoginFailure:error];
            }];
        }
            break;
        case LoginTypeWechat:
        {
            [[ThirdPartyLoginService sharedService] startThirdPartyLoginWithType:ThirdPartyLoginTypeWechat succeed:^(NSDictionary *respData) {
                [self handleThirdPartyLoginSucceed:respData type:ThirdPartyLoginTypeWechat];
            } failure:^(NSError *error) {
                [self handleThirdPartyLoginFailure:error];
            }];
        }
            break;
        case LoginTypeWeibo:
        {
            [[ThirdPartyLoginService sharedService] startThirdPartyLoginWithType:ThirdPartyLoginTypeWeibo succeed:^(NSDictionary *respData) {
                [self handleThirdPartyLoginSucceed:respData type:ThirdPartyLoginTypeWeibo];
            } failure:^(NSError *error) {
                [self handleThirdPartyLoginFailure:error];
            }];
        }
            break;
        default:
            break;
    }
}

- (void)handleThirdPartyLoginSucceed:(NSDictionary *)data type:(ThirdPartyLoginType)type {
    
    NSDictionary *userData = [data objectForKey:@"data"];
    if (userData && [userData isKindOfClass:[NSDictionary class]]) {
        NSString *uid = [NSString stringWithFormat:@"%@", [userData objectForKey:@"uid"]];
        NSString *skey = [userData objectForKey:@"skey"];
        if ([uid isNotNull] && [skey isNotNull]) {
            [self loginSuccessWithUid:uid skey:skey];

            NSInteger buryType = 0;
            switch (type) {
                case ThirdPartyLoginTypeQQ:
                {
                    buryType = 2;
                }
                    break;
                case ThirdPartyLoginTypeWechat:
                {
                    buryType = 3;
                }
                    break;
                case ThirdPartyLoginTypeWeibo:
                {
                    buryType = 4;
                }
                    break;
                default:
                {
                    buryType = 0;
                }
                    break;
            }
            if (buryType == 0) {
                return;
            }
            NSDictionary *params = @{@"uid":uid,
                                     @"type":@(buryType)};
            [BuryPointManager trackEvent:@"event_result_login" actionId:21501 params:params];
            
        }else{
            [[iToast makeText:@"登录失败"] show];
        }
    } else {
        [[iToast makeText:@"登录失败"] show];
    }
}

- (void)handleThirdPartyLoginFailure:(NSError *)error {
    if (error.userInfo) {
        NSInteger errNo = [[error.userInfo objectForKey:@"errno"] integerValue];
        NSString *errMsg = [error.userInfo objectForKey:kErrMsgKey];
        if (errNo == -2003) {//首次使用第三方登录，需要绑定手机号
            BindPhoneViewController *controller = [[BindPhoneViewController alloc] initWithNibName:@"BindPhoneViewController" bundle:nil];
            controller.delegate = self;
            [controller setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
        } else if ([errMsg length] > 0) {
            [[iToast makeText:errMsg] show];
        } else {
            errMsg = @"登录失败";
            [[iToast makeText:errMsg] show];
        }
    }
}

#pragma mark - 登录成功（拿到uid、skey）
- (void)loginSuccessWithUid:(NSString *)uid skey:(NSString *)skey {
    [[iToast makeText:@"登录成功"] show];
    [[User shareUser] updateUid:uid skey:skey];
    if (self.resultBlock) self.resultBlock(uid,nil);
    [self back];
}

#pragma mark - resetPassword

- (IBAction)resetPassword:(UIButton *)sender {
    ResetPasswordViewController *controller = [[ResetPasswordViewController alloc] initWithNibName:@"ResetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)showPassword:(UIButton *)sender {
    NSString *password = self.passwordTf.text;
    self.showPasswodBtn.selected = !self.showPasswodBtn.selected;
    [self.passwordTf setSecureTextEntry:!self.showPasswodBtn.selected];
    self.passwordTf.text = nil;
    self.passwordTf.text = password;
}

#pragma mark - gotoRegister

- (void)gotoRegister{
    RegisterViewController *controller = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - helpers

- (BOOL)validatePhone:(NSString *)phone password:(NSString *)password{
    
    if (phone.length==0) {
        [[iToast makeText:@"手机号不能为空"] show];
        return NO;
    }
    if (password.length==0) {
        [[iToast makeText:@"密码不能为空"] show];
        return NO;
    }
    if (password.length<6 || password.length>20) {
        [[iToast makeText:@"请输入6-20位至少包含数字和字母的密码"] show];
        return NO;
    }
    return YES;
}

- (NSArray<LoginItemModel *> *)supportedLoginTypes {
    
    NSMutableArray<LoginItemModel *>* loginArr = [[NSMutableArray alloc] init];
    //qq登录按钮
    if ([ThirdPartyLoginService isOnline:ThirdPartyLoginTypeQQ]) {
        LoginItemModel *model = [[LoginItemModel alloc] init];
        model.type = LoginTypeQQ;
        model.logo = [UIImage imageNamed:@"login_qq"];
        [loginArr addObject:model];
    }
    //微信按钮
    if ([ThirdPartyLoginService isOnline:ThirdPartyLoginTypeWechat]) {
        LoginItemModel *model = [[LoginItemModel alloc] init];
        model.type = LoginTypeWechat;
        model.logo = [UIImage imageNamed:@"login_wechat"];
        [loginArr addObject:model];
    }
    
    //微博按钮
    if([ThirdPartyLoginService isOnline:ThirdPartyLoginTypeWeibo])
    {
        LoginItemModel *model = [[LoginItemModel alloc] init];
        model.type = LoginTypeWeibo;
        model.logo = [UIImage imageNamed:@"login_weibo"];
        [loginArr addObject:model];
    }
    return loginArr;
}

- (UIButton *)btnWithItem:(LoginItemModel *)item tag:(NSUInteger)tag{
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = tag;
    btn.size = CGSizeMake(ThirdLoginBtnSize, ThirdLoginBtnSize);
    [btn setBackgroundImage:item.logo forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(thirdPartLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.thirdPartIconView addSubview:btn];
    return btn;
}

#pragma mark - BindPhoneViewControllerDelegate

- (void)didFinishedBindPoneActionWithUid:(NSString *)uid{
    if (self.resultBlock) self.resultBlock(uid,nil);
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
