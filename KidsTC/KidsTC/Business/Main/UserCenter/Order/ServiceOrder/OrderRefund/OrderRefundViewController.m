//
//  OrderRefundViewController.m
//  KidsTC
//
//  Created by Altair on 11/28/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "OrderRefundViewController.h"
#import "OrderRefundViewModel.h"
#import "iToast.h"
#import "TCProgressHUD.h"
#import "NSString+Category.h"

@interface OrderRefundViewController () <OrderRefundViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollBGView;
@property (strong, nonatomic) IBOutlet OrderRefundView *refundView;

@property (nonatomic, strong) OrderRefundViewModel *viewModel;

@property (nonatomic, copy) NSString *orderId;

- (BOOL)isValidParams;

@end

@implementation OrderRefundViewController

- (instancetype)initWithOrderId:(NSString *)orderId {
    self = [super initWithNibName:@"OrderRefundViewController" bundle:nil];
    if (self) {
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageId = 11005;
    
    if ([self.orderId isNotNull]) {
        self.trackParams = @{@"orderId":_orderId};
    }
    
    self.navigationItem.title= @"申请退款";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollBGView.alwaysBounceVertical = YES;
    self.scrollBGView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.refundView.delegate = self;
    [self.refundView setMinCount:1 andMaxCount:1];
    
    self.viewModel = [[OrderRefundViewModel alloc] initWithView:self.refundView];
    [self.viewModel.refundModel setOrderId:self.orderId];
    [self.viewModel startUpdateDataWithSucceed:^(NSDictionary *data) {
        [self.refundView setMinCount:1 andMaxCount:self.viewModel.refundModel.maxRefundCount];
    } failure:^(NSError *error) {
        NSString *msg = nil;
        if (error.userInfo) {
            msg = [error.userInfo objectForKey:@"data"];
        }
        if ([msg length] == 0) {
            msg = @"获取退款信息失败";
        }
        [[iToast makeText:msg] show];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [TCProgressHUD dismissSVP];
}

#pragma mark OrderRefundViewDelegate

- (void)orderRefundView:(OrderRefundView *)view didChangedRefundCountToValue:(NSUInteger)count {
    [self.viewModel.refundModel setRefundCount:count];
    [self.refundView reloadData];
}

- (void)didClickedReasonButtonOnOrderRefundView:(OrderRefundView *)view {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择退款原因" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    __weak OrderRefundViewController *weakSelf = self;
    for (OrderRefundReasonItem *item in self.viewModel.refundModel.refundReasons) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:item.reasonName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.viewModel.refundModel.selectedReasonItem = item;
            [weakSelf.refundView reloadData];
        }];
        [controller addAction:action];
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didClickedSubmitButtonOnOrderRefundView:(OrderRefundView *)view {
    if (![self isValidParams]) {
        return;
    }
    __weak OrderRefundViewController *weakSelf = self;
    [TCProgressHUD showSVP];
    [weakSelf.viewModel createOrderRefundWithSucceed:^(NSDictionary *data) {
        [[iToast makeText:@"退款申请提交成功"] show];
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderRefundViewController:didSucceedWithRefundForOrderId:)]) {
            [self.delegate orderRefundViewController:self didSucceedWithRefundForOrderId:self.orderId];
        }
        [self back];
        [TCProgressHUD dismissSVP];
    } failure:^(NSError *error) {
        NSString *msg = nil;
        if (error.userInfo) {
            msg = [error.userInfo objectForKey:@"data"];
        }
        if ([msg length] == 0) {
            msg = @"退款申请提交失败";
        }
        [[iToast makeText:msg] show];
        [TCProgressHUD dismissSVP];
    }];
}

#pragma mark Private methods

- (BOOL)isValidParams {
    if (!self.viewModel.refundModel.selectedReasonItem) {
        [[iToast makeText:@"请选择退款原因"] show];
        return NO;
    }
    if ([self.viewModel.refundModel.refundDescription length] < 10) {
        [[iToast makeText:@"请输入最少10个字的原因描述"] show];
        return NO;
    }
    return YES;
}

#pragma mark Super methods

#warning TODO...

//- (void)keyboardWillShow:(NSNotification *)notification {
//    [super keyboardWillShow:notification];
//    [self.scrollBGView setContentSize:CGSizeMake(0, self.view.frame.size.height + self.keyboardHeight)];
//}
//
//- (void)keyboardWillDisappear:(NSNotification *)notification {
//    [super keyboardWillDisappear:notification];
//    [self.scrollBGView setContentSize:CGSizeMake(0, self.view.frame.size.height - self.keyboardHeight)];
//}



@end
