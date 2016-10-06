//
//  FailureViewManager.m
//  KidsTC
//
//  Created by zhanping on 8/30/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FailureViewManager.h"
#import "WebFailureView.h"
#import "ReachabilityManager.h"

@interface FailureViewManager ()
@property (nonatomic, strong) WebFailureView *webFailureView;
@end

@implementation FailureViewManager
singleM(FailureViewManager)

- (WebFailureView *)webFailureView {
    if (!_webFailureView) {
        _webFailureView = [[[NSBundle mainBundle]loadNibNamed:@"WebFailureView" owner:self options:nil]firstObject];
    }
    return _webFailureView;
}

- (void)showType:(FailureViewType)type inView:(UIView *)view actionBlock:(void (^)(FailureViewManagerActionType type, id obj))actionBlock;{
    switch (type) {
        case FailureViewTypeWebView:
        {
            AFNetworkReachabilityStatus status = [ReachabilityManager shareReachabilityManager].status;
            if (status == AFNetworkReachabilityStatusNotReachable){
                [view layoutIfNeeded];
                self.webFailureView.frame = view.bounds;
                WeakSelf(self)
                self.webFailureView.actionBlock = ^void(WebFailureView *webFailureView){
                    StrongSelf(self)
                    if (actionBlock) actionBlock(FailureViewManagerActionTypeWebView,webFailureView);
                    [self.webFailureView removeFromSuperview];
                };
                [view addSubview:self.webFailureView];
            }
        }
            break;
        default:break;
    }
}


@end
