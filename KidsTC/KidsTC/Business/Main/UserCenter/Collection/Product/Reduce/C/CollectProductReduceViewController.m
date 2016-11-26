//
//  CollectProductReduceViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductReduceViewController.h"

#import "GHeader.h"
#import "SegueMaster.h"

#import "CollectProductReduceModel.h"
#import "CollectProductReduceView.h"

@interface CollectProductReduceViewController ()<CollectProductBaseViewDelegate>
@property (nonatomic, strong) CollectProductReduceView *reduceView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
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
    self.naviTheme = NaviThemeWihte;
}

#pragma mark - CollectProductBaseViewActionTypeDelegate

- (void)collectProductBaseView:(CollectProductBaseView *)view actionType:(CollectProductBaseViewActionType)type value:(id)value {
    switch (type) {
        case CollectProductBaseViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
            
        case CollectProductBaseViewActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"sort":@(CollectProductTypeReduct),
                            @"page":@(self.page),
                            @"pagecount":@(CollectProductPageCount)};
    [Request startWithName:@"GET_USER_INTEREST_LIST" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        CollectProductReduceModel *model = [CollectProductReduceModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.reduceView.items = self.items;
        [self.reduceView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.reduceView dealWithUI:0];
    }];
}

@end
