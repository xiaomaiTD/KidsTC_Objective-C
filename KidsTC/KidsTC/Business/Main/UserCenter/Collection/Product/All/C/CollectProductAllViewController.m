//
//  CollectProductAllViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductAllViewController.h"

#import "GHeader.h"
#import "SegueMaster.h"

#import "CollectProductAllModel.h"
#import "CollectProductAllView.h"

@interface CollectProductAllViewController ()<CollectProductBaseViewDelegate>
@property (nonatomic, strong) CollectProductAllView *allView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CollectProductAllViewController

- (void)loadView {
    CollectProductAllView *allView = [[CollectProductAllView alloc] init];
    allView.delegate = self;
    self.view =  allView;
    self.allView = allView;
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
    NSDictionary *param = @{@"sort":@(CollectProductTypeAll),
                            @"page":@(self.page),
                            @"pagecount":@(CollectProductPageCount)};
    [Request startWithName:@"GET_USER_INTEREST_LIST" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        CollectProductAllModel *model = [CollectProductAllModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.allView.items = self.items;
        [self.allView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.allView dealWithUI:0];
    }];
}

@end
