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
#import "NSString+Category.h"
#import "KTCFavouriteManager.h"

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

- (void)setEditing:(BOOL)editing {
    _editing = editing;
    self.allView.editing = editing;
}

#pragma mark - CollectProductBaseViewActionTypeDelegate

- (void)collectProductBaseView:(CollectProductBaseView *)view actionType:(CollectProductBaseViewActionType)type value:(id)value completion:(void (^)(id))completion{
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
        case CollectProductBaseViewActionTypeDelete:
        {
            [self delete:value completion:^(BOOL success) {
                if (completion) completion(@(success));
            }];
        }
            return;
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

- (void)delete:(CollectProductItem *)item completion:(void(^)(BOOL success))completion{
    if (![item.productSysNo isNotNull]) {
        [[iToast makeText:@"服务编号为空"] show];
        if (completion) completion(NO);
        return;
    }
    KTCFavouriteType type;
    switch (item.productType) {
        case ProductDetailTypeNormal:
        {
            type = KTCFavouriteTypeService;
        }
            break;
        case ProductDetailTypeTicket:
        {
            type = KTCFavouriteTypeTicketService;
        }
            break;
        case ProductDetailTypeFree:
        {
            type = KTCFavouriteTypeFreeService;
        }
            break;
        default:
        {
            type = KTCFavouriteTypeService;
        }
            break;
    }
    [TCProgressHUD showSVP];
    [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:item.productSysNo type:type succeed:^(NSDictionary *data) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(YES);
    } failure:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(NO);
    }];
}

@end
