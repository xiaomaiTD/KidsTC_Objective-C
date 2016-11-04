//
//  FailureViewManager.m
//  KidsTC
//
//  Created by zhanping on 8/30/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FailureViewManager.h"
#import "ReachabilityManager.h"

#import "WebFailureView.h"
#import "FailureViewLoadData.h"

@interface FailureViewManager ()
@property (nonatomic, strong) WebFailureView *webFailureView;
@property (nonatomic, strong) FailureViewLoadData *loadDataView;
@end

@implementation FailureViewManager
singleM(FailureViewManager)

- (WebFailureView *)webFailureView {
    if (!_webFailureView) {
        _webFailureView = [self viewWithNib:@"WebFailureView"];
    }
    return _webFailureView;
}

- (FailureViewLoadData *)loadDataView {
    if (!_loadDataView) {
        _loadDataView = [self viewWithNib:@"FailureViewLoadData"];
    }
    return _loadDataView;
}

- (id)viewWithNib:(NSString *)nib {
    return [[[NSBundle mainBundle]loadNibNamed:nib owner:self options:nil]firstObject];
}

- (void)showType:(FailureViewType)type inView:(UIView *)view actionBlock:(void (^)(FailureViewManagerActionType type, id obj))actionBlock;{
    switch (type) {
        case FailureViewTypeWebView:
        {
            AFNetworkReachabilityStatus status = [ReachabilityManager shareReachabilityManager].status;
            if (status == AFNetworkReachabilityStatusNotReachable){
                /*[view layoutIfNeeded];
                self.webFailureView.frame = view.bounds;
                WeakSelf(self)
                self.webFailureView.actionBlock = ^void(WebFailureView *webFailureView){
                    StrongSelf(self)
                    [self.webFailureView removeFromSuperview];
                    if (actionBlock) actionBlock(FailureViewManagerActionTypeWebView,webFailureView);
                };
                [view addSubview:self.webFailureView];*/
                
                self.loadDataView.frame = view.bounds;
                [view addSubview:self.loadDataView];
                WeakSelf(self)
                self.loadDataView.actionBlock = ^void (FailureViewLoadData *failureViewLoadData, FailureViewLoadDataActionType actionType) {
                    StrongSelf(self)
                    FailureViewManagerActionType type;
                    switch (actionType) {
                        case FailureViewLoadDataActionTypeCheckNetWork:
                        {
                            type = FailureViewManagerActionTypeCheckNetwork;
                            NSURL *url = [NSURL URLWithString:@"prefs:root="];
                            if([[UIApplication sharedApplication] canOpenURL:url]) {
                                [[UIApplication sharedApplication] openURL:url];
                            }
                        }
                            break;
                        case FailureViewLoadDataActionTypeRefresh:
                        {
                            type = FailureViewManagerActionTypeRefrech;
                        }
                            break;
                    }
                    [self.loadDataView removeFromSuperview];
                    if (actionBlock) actionBlock(type,failureViewLoadData);
                };
            }
        }
            break;
        case FailureViewTypeLoadData:
        {
            self.loadDataView.frame = view.bounds;
            [view addSubview:self.loadDataView];
            WeakSelf(self)
            self.loadDataView.actionBlock = ^void (FailureViewLoadData *failureViewLoadData, FailureViewLoadDataActionType actionType) {
                StrongSelf(self)
                FailureViewManagerActionType type;
                switch (actionType) {
                    case FailureViewLoadDataActionTypeCheckNetWork:
                    {
                        type = FailureViewManagerActionTypeCheckNetwork;
                        NSURL *url = [NSURL URLWithString:@"prefs:root="];
                        if([[UIApplication sharedApplication] canOpenURL:url]) {
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }
                        break;
                    case FailureViewLoadDataActionTypeRefresh:
                    {
                        type = FailureViewManagerActionTypeRefrech;
                    }
                        break;
                }
                [self.loadDataView removeFromSuperview];
                if (actionBlock) actionBlock(type,failureViewLoadData);
            };
        }
            break;
        default:break;
    }
}


@end
