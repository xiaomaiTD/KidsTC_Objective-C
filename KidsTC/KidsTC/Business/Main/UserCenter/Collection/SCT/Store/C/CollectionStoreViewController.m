//
//  CollectionStoreViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreViewController.h"

#import "GHeader.h"
#import "SegueMaster.h"

#import "CollectionStoreModel.h"
#import "CollectionStoreView.h"

@interface CollectionStoreViewController ()<CollectionSCTBaseViewDelegate>
@property (nonatomic, strong) CollectionStoreView *storeView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CollectionStoreViewController

- (void)loadView {
    
    CollectionStoreView *storeView = [[CollectionStoreView alloc] init];
    storeView.delegate = self;
    self.view  = storeView;
    self.storeView = storeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
}


#pragma mark - CollectionSCTBaseViewDelegate

- (void)collectionSCTBaseView:(CollectionSCTBaseView *)view actionType:(CollectionSCTBaseViewActionType)type value:(id)value {
    switch (type) {
        case CollectionSCTBaseViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
            
        case CollectionSCTBaseViewActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"page":@(self.page),
                            @"pagecount":@(CollectionSCTPageCount)};
    [Request startWithName:@"GET_USER_INTEREST_STORE_LST" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        CollectionStoreModel *model = [CollectionStoreModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.storeView.items = self.items;
        [self.storeView dealWithUI:0];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.storeView dealWithUI:0];
    }];
}

@end
