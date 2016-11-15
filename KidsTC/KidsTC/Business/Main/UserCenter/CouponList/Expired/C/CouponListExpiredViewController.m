//
//  CouponListExpiredViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListExpiredViewController.h"
#import "CouponListExpiredView.h"

@interface CouponListExpiredViewController ()<CouponListBaseViewDelegate>
@property (nonatomic, strong) CouponListExpiredView *expiredView;
@end

@implementation CouponListExpiredViewController

- (void)loadView {
    CouponListExpiredView *expiredView = [[CouponListExpiredView alloc] init];
    expiredView.delegate = self;
    self.view =  expiredView;
    self.expiredView = expiredView;
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
            [self.expiredView endRefresh:NO];
        });
    });
}



@end
