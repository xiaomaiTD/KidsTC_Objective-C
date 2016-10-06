//
//  ArticleWritePreviewViewController.m
//  KidsTC
//
//  Created by zhanping on 2016/9/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleWritePreviewViewController.h"

#import "ArticleWriteBaseCell.h"
#import "ArticleWriteCategoryCell.h"
#import "ArticleWriteTitleCell.h"
#import "ArticleWriteContentCell.h"
#import "ArticleWriteCoverCell.h"
#import "ArticleWriteImageCell.h"
#import "ArticleWriteBottomView.h"

static NSString *const ArticleWriteBaseCellID     = @"ArticleWriteBaseCellID";
static NSString *const ArticleWriteCategoryCellID = @"ArticleWriteCategoryCellID";
static NSString *const ArticleWriteTitleCellID    = @"ArticleWriteTitleCellID";
static NSString *const ArticleWriteContentCellID  = @"ArticleWriteContentCellID";
static NSString *const ArticleWriteCoverCellID    = @"ArticleWriteCoverCellID";
static NSString *const ArticleWriteImageCellID    = @"ArticleWriteImageCellID";

@interface ArticleWritePreviewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableview;
@end

@implementation ArticleWritePreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_models enumerateObjectsUsingBlock:^(ArticleWriteModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.canEdit = NO;
    }];
    
    [self setupTableViews];
}

- (void)setupTableViews {
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.estimatedRowHeight = 44.0f;
    tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    _tableview = tableview;
    
    [tableview registerClass:[ArticleWriteBaseCell class] forCellReuseIdentifier:ArticleWriteBaseCellID];
    [tableview registerNib:[UINib nibWithNibName:@"ArticleWriteCategoryCell" bundle:nil] forCellReuseIdentifier:ArticleWriteCategoryCellID];
    [tableview registerNib:[UINib nibWithNibName:@"ArticleWriteTitleCell" bundle:nil] forCellReuseIdentifier:ArticleWriteTitleCellID];
    [tableview registerNib:[UINib nibWithNibName:@"ArticleWriteContentCell" bundle:nil] forCellReuseIdentifier:ArticleWriteContentCellID];
    [tableview registerNib:[UINib nibWithNibName:@"ArticleWriteCoverCell" bundle:nil] forCellReuseIdentifier:ArticleWriteCoverCellID];
    [tableview registerNib:[UINib nibWithNibName:@"ArticleWriteImageCell" bundle:nil] forCellReuseIdentifier:ArticleWriteImageCellID];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleWriteModel *model = _models[indexPath.row];
    NSString *ID = [self IdWith:model.type];
    ArticleWriteBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = model;
    return cell;
}

- (NSString *)IdWith:(ArticleWriteModelType)type {
    NSString *ID = ArticleWriteBaseCellID;
    switch (type) {
        case ArticleWriteModelTypeClass:
        {
            ID = ArticleWriteCategoryCellID;
        }
            break;
        case ArticleWriteModelTypeTitle:
        {
            ID = ArticleWriteTitleCellID;
        }
            break;
        case ArticleWriteModelTypeContent:
        {
            ID = ArticleWriteContentCellID;
        }
            break;
        case ArticleWriteModelTypeCover:
        {
            ID = ArticleWriteCoverCellID;
        }
            break;
        case ArticleWriteModelTypeImage:
        {
            ID = ArticleWriteImageCellID;
        }
            break;
        default:
        {
            ID = ArticleWriteBaseCellID;
        }
            break;
    }
    return ID;
}

@end
