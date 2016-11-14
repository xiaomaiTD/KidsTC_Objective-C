//
//  CollectProductReduceViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductReduceViewController.h"
#import "CollectProductReduceView.h"

@interface CollectProductReduceViewController ()<CollectProductBaseViewDelegate>
@property (nonatomic, strong) CollectProductReduceView *reduceView;
@end

@implementation CollectProductReduceViewController

- (void)loadView {
    CollectProductReduceView *reduceView = [[CollectProductReduceView alloc] init];
    reduceView.delegate = self;
    self.view = reduceView;
    self.reduceView = reduceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - CollectProductBaseViewActionTypeDelegate

- (void)collectProductBaseView:(CollectProductBaseView *)view actionType:(CollectProductBaseViewActionType)type value:(id)value {
    switch (type) {
        case CollectProductBaseViewActionTypeLoadData:
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
            [self.reduceView endRefresh:NO];
        });
    });
}

@end
