//
//  CollectProductCategoryViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductCategoryViewController.h"
#import "CollectProductCategoryView.h"

@interface CollectProductCategoryViewController ()<CollectProductBaseViewDelegate>
@property (nonatomic, strong) CollectProductCategoryView *categoryView;
@end

@implementation CollectProductCategoryViewController

- (void)loadView {
    CollectProductCategoryView *categoryView = [[CollectProductCategoryView alloc] init];
    categoryView.delegate = self;
    self.view = categoryView;
    self.categoryView = categoryView;
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
            [self.categoryView endRefresh:NO];
        });
    });
}

@end
