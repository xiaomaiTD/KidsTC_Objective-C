//
//  CollectionContentViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionContentViewController.h"

#import "GHeader.h"
#import "SegueMaster.h"

#import "CollectionContentModel.h"
#import "CollectionContentView.h"

@interface CollectionContentViewController ()<CollectionSCTBaseViewDelegate>
@property (nonatomic, strong) CollectionContentView *contentView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CollectionContentViewController

- (void)loadView {
    
    CollectionContentView *contentView = [[CollectionContentView alloc] init];
    contentView.delegate = self;
    self.view  = contentView;
    self.contentView = contentView;
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
        default:
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"page":@(self.page),
                            @"pageCount":@(CollectionSCTPageCount)};
    [Request startWithName:@"GET_USER_COLLECT_ARTICLE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        CollectionContentModel *model = [CollectionContentModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.contentView.items = self.items;
        [self.contentView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.contentView dealWithUI:0];
    }];
}

@end
