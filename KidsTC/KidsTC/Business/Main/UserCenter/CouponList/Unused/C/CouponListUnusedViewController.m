
//
//  CouponListUnusedViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListUnusedViewController.h"
#import "CouponListUnusedView.h"

@interface CouponListUnusedViewController ()<CouponListBaseViewDelegate>
@property (nonatomic, strong) CouponListUnusedView *unusedView;
@end

@implementation CouponListUnusedViewController

- (void)loadView {
    CouponListUnusedView *unusedView = [[CouponListUnusedView alloc] init];
    unusedView.delegate = self;
    self.view =  unusedView;
    self.unusedView = unusedView;
}


#pragma mark - CollectProductBaseViewActionTypeDelegate

- (void)couponListBaseView:(CouponListBaseView *)view actionType:(CouponListBaseViewActionType)type value:(id)value {
    switch (type) {
        case CouponListBaseViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
            
        default:
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:2];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.unusedView endRefresh:NO];
        });
    });
}



@end
