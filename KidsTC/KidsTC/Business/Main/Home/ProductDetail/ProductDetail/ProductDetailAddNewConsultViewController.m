//
//  ProductDetailAddNewConsultViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailAddNewConsultViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"

static CGFloat const kAnimationDuration = 0.2;

@interface ProductDetailAddNewConsultViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputContentConstraintB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputContentConstraintH;

@end

@implementation ProductDetailAddNewConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}

- (IBAction)calcel:(UIButton *)sender {
    [self.textView resignFirstResponder];
}

- (IBAction)sure:(UIButton *)sender {
    [self send];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    [super keyboardWillShow:notification];
    [self show];
}

- (void)keyboardWillDisappear:(NSNotification *)notification{
    [super keyboardWillDisappear:notification];
    [self hide];
}

- (void)show {
    self.inputContentConstraintB.constant = - self.inputContentConstraintH.constant;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.inputContentConstraintB.constant = self.keyboardHeight;
        [self.view layoutIfNeeded];
    }];
}

- (void)hide {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.view.backgroundColor = [UIColor clearColor];
        self.inputContentConstraintB.constant = - self.inputContentConstraintH.constant;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)send {
    if (![self.productId isNotNull]) {
        [[iToast makeText:@"没有关联商品编号！"] show];
        return;
    }
    NSString *content = self.textView.text;
    if (![content isNotNull]) {
        [[iToast makeText:@"请输入内容"] show];
        return;
    }
    NSDictionary *param = @{@"relationNo":self.productId,
                            @"advisoryType":@"1",
                            @"content":content};
    [TCProgressHUD showSVP];
    [Request startWithName:@"ADD_ADVISORY" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"发表成功！"] show];
        if ([self.delegate respondsToSelector:@selector(productDetailAddNewConsultViewController:actionType:value:)]) {
            [self.delegate productDetailAddNewConsultViewController:self
                                                         actionType:ProductDetailAddNewConsultViewControllerActionTypeReload
                                                              value:nil];
        }
        [self hide];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"发表失败！"] show];
    }];
}

@end
