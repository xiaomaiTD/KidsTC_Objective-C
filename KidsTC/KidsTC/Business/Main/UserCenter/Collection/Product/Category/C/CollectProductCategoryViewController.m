//
//  CollectProductCategoryViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductCategoryViewController.h"
#import "CollectProductCategoryView.h"

@interface CollectProductCategoryViewController ()<CollectProductBaseViewActionTypeDelegate>
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
    self.view.backgroundColor = [UIColor greenColor];
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
    
}

@end
