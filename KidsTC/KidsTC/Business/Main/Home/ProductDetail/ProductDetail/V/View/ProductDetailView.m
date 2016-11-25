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
@property (nonatomic, strong) ProductDetailViewBaseHeader *header;
@property (nonatomic, strong) NSArray<NSArray<ProductDetailBaseCell *> *> *sections;
@property (nonatomic, strong) ProductDetailBaseToolBar *toolBar;
@property (nonatomic, strong) ProductDetailCountDownView *countDownView;
@property (nonatomic, strong) ProductDetailTwoColumnToolBar *twoColumnToolBar;
@end

@implementation ProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _subViewProvider = [ProductDetailSubViewsProvider shareProductDetailSubViewsProvider];
        
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

- (void)setData:(ProductDetailData *)data {
    _data = data;
    
    _subViewProvider.data = data;
    _sections = _subViewProvider.sections;
    _header.data = data;
    _twoColumnToolBar.data = data;
    _countDownView.data = data;
    _toolBar.data = data;
    
    [self reload];
}

- (void)reload {
    [self.tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidScroll:self.tableView];
    });
}

- (void)action:(ProductDetailViewActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productDetailView:actionType:value:)]) {
        [self.delegate productDetailView:self actionType:type value:value];
    }
}

#pragma mark - setupTableView
- (void)setupTableView {
    
    CGRect tableViewFrame;
    switch (_subViewProvider.type) {
        case ProductDetailTypeNormal:
        {
            tableViewFrame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - kProductDetailBaseToolBarHeight);
        }
            break;
        case ProductDetailTypeTicket:
        {
            tableViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kProductDetailBaseToolBarHeight);
        }
            break;
        case ProductDetailTypeFree:
        {
            tableViewFrame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - kProductDetailBaseToolBarHeight);
        }
            break;
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60.0f;
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [self addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    TCLog(@"offsetY:%f",offsetY);
    [self setupTwoColumnToolBarFrame:offsetY];
    [self action:ProductDetailViewDidScroll value:@(offsetY)];
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
    
    switch (type) {
        case ProductDetailViewActionTypeOpenWebView:
        {
            [self reload];
        }
            break;
        case ProductDetailViewActionTypeTicketOpenDes:
        {
            [self reload];
        }
            break;
        default:
            break;
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

- (void)setupTwoColumnToolBarFrame:(CGFloat)offsetY {
    switch (_subViewProvider.type) {
        case ProductDetailTypeNormal:
        case ProductDetailTypeFree:
        {
            CGFloat twoColumnCellY = CGRectGetMinY(_subViewProvider.twoColumnCell.frame);
            if (twoColumnCellY<=0) {
                _twoColumnToolBar.hidden = YES;
            }else{
                CGFloat y = twoColumnCellY + 64 - kTwoColumnToolBarH - offsetY;
                if (y<64) y = 64;
                CGRect frame = _twoColumnToolBar.frame;
                frame.origin.y = y;
                _twoColumnToolBar.frame = frame;
                _twoColumnToolBar.hidden = NO;
            }
        }
            break;
        case ProductDetailTypeTicket:
        {
            CGFloat twoColumnCellY = CGRectGetMinY(_subViewProvider.twoColumnCell.frame);
            if (twoColumnCellY<=0) {
                _twoColumnToolBar.hidden = YES;
            }else{
                CGFloat y = twoColumnCellY - kTwoColumnToolBarH - offsetY;
                if (y<64) y = 64;
                CGRect frame = _twoColumnToolBar.frame;
                frame.origin.y = y;
                _twoColumnToolBar.frame = frame;
                _twoColumnToolBar.hidden = NO;
            }
        }
            break;
    }
}

#pragma mark ProductDetailTwoColumnToolBarDelegate
- (void)productDetailTwoColumnToolBar:(ProductDetailTwoColumnToolBar *)toolBar ationType:(ProductDetailTwoColumnToolBarActionType)type value:(id)value {
    [self action:(ProductDetailViewActionType)type value:value];
    _sections = _subViewProvider.sections;
    [self reload];
}

#pragma mark - setupCountDownView
- (void)setupCountDownView {
    _countDownView = _subViewProvider.countDownView;
    CGFloat countDownView_y = SCREEN_HEIGHT - kProductDetailCountDownViewHeight - kProductDetailBaseToolBarHeight;
    _countDownView.frame = CGRectMake(0, countDownView_y, SCREEN_WIDTH, kProductDetailCountDownViewHeight);
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
    CGFloat toolBar_y = SCREEN_HEIGHT - kProductDetailBaseToolBarHeight;
    _toolBar.frame = CGRectMake(0, toolBar_y, SCREEN_WIDTH, kProductDetailBaseToolBarHeight);
    _toolBar.delegate = self;
    [self addSubview:_toolBar];
    _toolBar.hidden = YES;
}

#pragma mark ProductDetailToolBarDelegate
- (void)productDetailBaseToolBar:(ProductDetailBaseToolBar *)toolBar actionType:(ProductDetailBaseToolBarActionType)type value:(id)value {
    [self action:(ProductDetailViewActionType)type value:value];
}

@end
