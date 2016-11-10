//
//  ProductDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailView.h"

#import "OnlineCustomerService.h"
#import "NSString+Category.h"
#import "NSArray+Category.h"

#import "ProductDetailSubViewsProvider.h"
#import "ProductDetailTwoColumnToolBar.h"
#import "ProductDetailBaseToolBar.h"
#import "ProductDetailCountDownView.h"

static NSString *const ID = @"UITableViewCell";

@interface ProductDetailView ()<UITableViewDelegate,UITableViewDataSource,ProductDetailBaseCellDelegate,ProductDetailCountDownViewDelegte,ProductDetailBaseToolBarDelegate,ProductDetailTwoColumnToolBarDelegate>
@property (nonatomic, strong) ProductDetailSubViewsProvider *subViewProvider;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<ProductDetailBaseCell *> *> *sections;
@property (nonatomic, strong) ProductDetailTwoColumnToolBar *twoColumnToolBar;
@property (nonatomic, strong) ProductDetailCountDownView *countDownView;
@property (nonatomic, strong) ProductDetailBaseToolBar *toolBar;
@property (nonatomic, assign) CGPoint tableViewContentOffset;
@end

@implementation ProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _subViewProvider = [ProductDetailSubViewsProvider shareProductDetailSubViewsProvider];
        _subViewProvider.type = _type;
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self setupTableView];
    [self setupTwoColumnToolBar];
    [self setupCountDownView];
    [self setupToolBar];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    
    _tableView.frame = CGRectMake(0, 64, self_w, self_h - 64 - kProductDetailBaseToolBarHeight);
    [self setupTwoColumnToolBarFrame];
    CGFloat countDownView_y = self_h - kProductDetailCountDownViewHeight - kProductDetailBaseToolBarHeight;
    _countDownView.frame = CGRectMake(0, countDownView_y, self_w, kProductDetailCountDownViewHeight);
    CGFloat toolBar_y = self_h - kProductDetailBaseToolBarHeight;
    _toolBar.frame = CGRectMake(0, toolBar_y, self_w, kProductDetailBaseToolBarHeight);
}

- (void)setData:(ProductDetailData *)data {
    _data = data;
    
    _subViewProvider.data = data;
    _sections = _subViewProvider.sections;
    _twoColumnToolBar.count = data.advisoryCount;
    _countDownView.data = data;
    _toolBar.data = data;
    [self reload];
}

- (void)reload {
    [self.tableView reloadData];
    self.tableView.contentOffset = self.tableViewContentOffset;
    [self scrollViewDidScroll:self.tableView];
}

- (void)action:(ProductDetailViewActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productDetailView:actionType:value:)]) {
        [self.delegate productDetailView:self actionType:type value:value];
    }
}

#pragma mark - setupTableView
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60.0f;
    [self addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.tableViewContentOffset = scrollView.contentOffset;
    [self setupTwoColumnToolBarFrame];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sections.count>section) {
        return self.sections[section].count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == _subViewProvider.twoColumnSectionUsed) {
        return CGRectGetHeight(_twoColumnToolBar.bounds);
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSInteger count = self.sections.count;
    if (count > section) {
        return (count-1 == section && _data.showCountDown)?42:12;
    }
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (self.sections.count>section) {
        NSArray<ProductDetailBaseCell *> *rows = [self.sections objectAtIndexCheck:section];
        if (rows.count>row) {
            ProductDetailBaseCell *cell = [rows objectAtIndexCheck:row];
            cell.delegate = self;
            cell.data = _data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:ID];
}

#pragma mark ProductDetailBaseCellDelegate
- (void)productDetailBaseCell:(ProductDetailBaseCell *)cell actionType:(ProductDetailBaseCellActionType)type value:(id)value {
    [self action:(ProductDetailViewActionType)type value:value];
    if (type == ProductDetailViewActionTypeOpenWebView) {
        _subViewProvider.twoColumnCellUsed.webViewHasOpen = YES;
        [self reload];
    }
}

#pragma mark - setupTwoColumnToolBar
- (void)setupTwoColumnToolBar {
    _twoColumnToolBar = _subViewProvider.twoColumnToolBar;
    _twoColumnToolBar.delegate = self;
    [self addSubview:_twoColumnToolBar];
    _twoColumnToolBar.hidden = YES;
    _twoColumnToolBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTwoColumnToolBarH);
}

- (void)setupTwoColumnToolBarFrame {
    CGFloat offsetY = _tableViewContentOffset.y;
    CGFloat twoColumnCellY = CGRectGetMinY(_subViewProvider.twoColumnCellUsed.frame) + 64;
    if (twoColumnCellY <= 64) {//当twoColumnCellY<=64时，说明twoColumnCell还没有被添加到界面，此时按照正常计算方式计算高度是不对的。
        _twoColumnToolBar.hidden = YES;
    }else{
        CGFloat y = twoColumnCellY - kTwoColumnToolBarH - offsetY;
        if ( y < 64 && y > - CGRectGetHeight(_subViewProvider.twoColumnCellUsed.frame) ) y = 64;
        CGRect frame = _twoColumnToolBar.frame;
        frame.origin.y = y;
        _twoColumnToolBar.frame = frame;
        _twoColumnToolBar.hidden = NO;
    }
}

- (void)resetTwoColumnToolBarShowType:(ProductDetailTwoColumnToolBarActionType)type {
    switch (type) {
        case ProductDetailTwoColumnToolBarActionTypeDetail:
        {
            _subViewProvider.twoColumnCellUsed.showType = ProductDetailTwoColumnShowTypeDetail;
            _subViewProvider.twoColumnBottomBarCellUsed.showType = ProductDetailTwoColumnShowTypeDetail;
        }
            break;
        case ProductDetailTwoColumnToolBarActionTypeConsult:
        {
            _subViewProvider.twoColumnCellUsed.showType = ProductDetailTwoColumnShowTypeConsult;
            _subViewProvider.twoColumnBottomBarCellUsed.showType = ProductDetailTwoColumnShowTypeConsult;
        }
            break;
    }
}

#pragma mark ProductDetailTwoColumnToolBarDelegate
- (void)productDetailTwoColumnToolBar:(ProductDetailTwoColumnToolBar *)toolBar ationType:(ProductDetailTwoColumnToolBarActionType)type value:(id)value {
    [self action:(ProductDetailViewActionType)type value:value];
    [self resetTwoColumnToolBarShowType:type];
    [self reload];
}

#pragma mark - setupCountDownView
- (void)setupCountDownView {
    _countDownView = _subViewProvider.countDownView;
    _countDownView.delegate = self;
    [self addSubview:_countDownView];
    _countDownView.hidden = YES;
}

#pragma mark ProductDetailCountDownViewDelegte
- (void)productDetailCountDownView:(ProductDetailCountDownView *)view actionType:(ProductDetailCountDownViewActionType)type value:(id)value {
    [self action:(ProductDetailViewActionType)type value:value];
}

#pragma mark - setupToolBar
- (void)setupToolBar {
    _toolBar = _subViewProvider.toolBar;
    _toolBar.delegate = self;
    [self addSubview:_toolBar];
    _toolBar.hidden = YES;
}

#pragma mark ProductDetailToolBarDelegate
- (void)productDetailBaseToolBar:(ProductDetailBaseToolBar *)toolBar actionType:(ProductDetailBaseToolBarActionType)type value:(id)value {
    [self action:(ProductDetailViewActionType)type value:value];
}

@end
