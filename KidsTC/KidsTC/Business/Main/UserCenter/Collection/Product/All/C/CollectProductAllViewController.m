//
//  CollectProductAllViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductAllViewController.h"
#import "CollectProductAllView.h"

@interface CollectProductAllViewController ()<CollectProductBaseViewDelegate>
@property (nonatomic, strong) CollectProductAllView *allView;
@end

@implementation CollectProductAllViewController

- (void)loadView {
    CollectProductAllView *allView = [[CollectProductAllView alloc] init];
    allView.delegate = self;
    self.view =  allView;
    self.allView = allView;
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
            [self.allView endRefresh:NO];
        });
    });
}

@end
