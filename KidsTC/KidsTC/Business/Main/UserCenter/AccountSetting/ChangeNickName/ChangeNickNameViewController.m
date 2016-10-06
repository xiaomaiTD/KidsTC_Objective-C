//
//  ChangeNickNameViewController.m
//  KidsTC
//
//  Created by zhanping on 7/27/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ChangeNickNameViewController.h"
#import "UIBarButtonItem+Category.h"
#import "GHeader.h"

@interface ChangeNickNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) UIButton *sureBtn;
@end

@implementation ChangeNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改昵称";
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem itemWithTitle:@"确定"
                           postion:UIBarButtonPositionRight
                            target:self
                            action:@selector(rightBarButtonItemAction:)
                      andGetButton:^(UIButton *btn) {
                          self.sureBtn = btn;
                      }];
    if (self.oldNickName.length>0) self.textField.text = self.oldNickName;
    [self.textField becomeFirstResponder];
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)rightBarButtonItemAction:(UIButton *)btn{
    NSString *nickName = self.textField.text;
    if (![self validateName:nickName]) return;
    [TCProgressHUD showSVP];
    NSDictionary *param = @{@"userName":nickName};
    [Request startWithName:@"USER_UPDATE_INFO" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [iToast makeText:@"改昵称成功"];
        if (self.successBlock) {
            if (self.successBlock(nickName)) [self back];
        };
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [iToast makeText:@"修改昵称失败"];
    }];
}

- (BOOL)validateName:(NSString *)name{
    if (name.length == 0) {
        [[iToast makeText:@"请输入新的昵称"] show];
        return NO;
    }
    if (name.length > 50) {
        [[iToast makeText:@"昵称过长"] show];
        return NO;
    }
    if ([name isEqualToString:self.oldNickName]) {
        [[iToast makeText:@"与原有昵称相同"] show];
        return NO;
    }
    if ([name rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].location != NSNotFound) {
        [[iToast makeText:@"请勿包含非法字符"] show];
        return NO;
    }
    return YES;
}

- (IBAction)tapScrollView:(UITapGestureRecognizer *)sender {
    [self.textField resignFirstResponder];
}

@end
