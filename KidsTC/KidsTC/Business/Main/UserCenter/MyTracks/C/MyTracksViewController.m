//
//  MyTracksViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksViewController.h"
#import "UIBarButtonItem+Category.h"
#import "GHeader.h"
#import "SegueMaster.h"
#import "NSString+Category.h"

#import "MyTracksModel.h"
#import "MyTracksView.h"

@interface MyTracksViewController ()<MyTracksViewDelegate>
@property (nonatomic, strong) MyTracksView *tracksView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation MyTracksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的足迹";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    MyTracksView *tracksView = [[MyTracksView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tracksView.delegate = self;
    [self.view addSubview:tracksView];
    self.tracksView = tracksView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"编辑" postion:UIBarButtonPositionRight target:self action:@selector(edit:) andGetButton:^(UIButton *btn) {
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitle:@"完成" forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    }];
}

- (void)edit:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self.tracksView edit:btn.selected];
}

#pragma mark - MyTracksViewDelegate

- (void)myTracksView:(MyTracksView *)view actionType:(MyTracksViewActionType)type value:(id)value completion:(void(^)(id value))completion {
    switch (type) {
        case MyTracksViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
        case MyTracksViewActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
            
        case MyTracksViewActionTypeDelete:
        {
            [self delete:value completion:^(BOOL success) {
                if (completion) completion(@(success));
            }];
        }
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"page":@(self.page),
                            @"pagecount":@(MyTracksPageCount)};
    [Request startWithName:@"GET_BROWSE_HISTORY_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        MyTracksModel *model = [MyTracksModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            MyTracksDateItem *firstDateItem_old = nil;
            NSMutableArray *oldDateItems = [NSMutableArray arrayWithArray:self.items];
            if (oldDateItems.count>0) {
                firstDateItem_old = oldDateItems.lastObject;
            }
            MyTracksDateItem *firstDateItem_new = nil;
            NSMutableArray *newDateItems = [NSMutableArray arrayWithArray:model.data];
            if (newDateItems.count>0) {
                firstDateItem_new = newDateItems.firstObject;
            }
            if (firstDateItem_old && firstDateItem_new) {
                if ([firstDateItem_old.time isEqualToString:firstDateItem_new.time]) {
                    NSMutableArray *oldItems = [NSMutableArray arrayWithArray:firstDateItem_old.BrowseHistoryLst];
                    [oldItems addObjectsFromArray:firstDateItem_new.BrowseHistoryLst];
                    firstDateItem_old.BrowseHistoryLst = [NSArray arrayWithArray:oldItems];
                    [newDateItems removeObjectAtIndex:0];
                }
            }
            [oldDateItems addObjectsFromArray:newDateItems];
            self.items = [NSArray arrayWithArray:oldDateItems];
        }
        self.tracksView.items = self.items;
        [self.tracksView dealWithUI:model.currentCount];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tracksView dealWithUI:0];
    }];
}

- (void)delete:(NSString *)productId completion:(void(^)(BOOL success))completion{
    if (![productId isNotNull]) {
        [[iToast makeText:@"服务编号为空"] show];
        if (completion) completion(NO);
        return;
    }
    NSDictionary *param = @{@"id":productId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"DEL_USER_BROWSE_HISTORY" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(NO);
    }];
}


@end
