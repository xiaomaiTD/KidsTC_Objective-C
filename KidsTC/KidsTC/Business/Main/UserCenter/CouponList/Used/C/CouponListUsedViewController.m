//
//  CouponListUsedViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListUsedViewController.h"
#import "CouponListUsedView.h"

@interface CouponListUsedViewController ()<CouponListBaseViewDelegate>
@property (nonatomic, strong) CouponListUsedView *usedView;
@end

@implementation CouponListUsedViewController

- (void)loadView {
    CouponListUsedView *usedView = [[CouponListUsedView alloc] init];
    usedView.delegate = self;
    self.view =  usedView;
    self.usedView = usedView;
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
            [self.usedView endRefresh:NO];
        });
    });
}

@end
