//
//  SearchTableViewController.m
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchTableViewController.h"
#import "SearchHotKeywordsManager.h"
#import "ZPPopover.h"
#import "SearchHotKeywordsView.h"
#import "SearchHistoryKeywordsManager.h"
#import "SearchTableViewCell.h"
#import "SearchTypeItem.h"
#import "SearchTableTextField.h"
#import "SearchResultViewController.h"
#import "Macro.h"
#import "UIBarButtonItem+Category.h"

#define SectionHeaderViewHight 40
#define SectionFooterViewHight 60

@interface SearchTableViewController ()<UITextFieldDelegate,ZPPopoverDelegate,SearchHotKeywordsViewDelegate,SearchTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SearchTableTextField *textField;
@property (nonatomic, strong) ZPPopover *popover;

@property (nonatomic, strong) SearchHotKeywordsView *searchHotKeywordsView;
@property (nonatomic, strong) UIView *sectionHeaderView;
@property (nonatomic, strong) UIView *sectionFooterView;

@property (nonatomic, strong) SearchHotKeywordsModel *searchHotKeywordsModel;
@property (nonatomic, strong) SearchHistoryKeywordsModel *searchHistoryKeywordsModel;
@property (nonatomic, assign) NSUInteger currentSearchSelectedIndex;
@property (nonatomic, strong) NSArray<SearchTypeItem *> *searchTypeItemsArray;


@end

static NSString *reuseIdentifier = @"SearchTableViewCell";
@implementation SearchTableViewController

#pragma mark - lazy load

- (SearchTableTextField *)textField{
    
    if (!_textField) {
        SearchTableTextField *textField = [[SearchTableTextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-0, 30)];
        __weak typeof(self) weakSelf = self;
        textField.didClickOnSearchTypeBtn = ^{
            SearchTableViewController *strongSelf = weakSelf;
            [strongSelf.popover show];
        };
        textField.delegate = self;
        _textField = textField;
    }
    return _textField;
}

- (ZPPopover *)popover{
    if (!_popover) {
        CGFloat barBtnX = 88;
        CGFloat barBtnY = 50;
        
        ZPPopoverItem *popoverItem1 = [ZPPopoverItem makeZpMenuItemWithImageName:@"bizicon_service_n" title:@"服务"];
        ZPPopoverItem *popoverItem2 = [ZPPopoverItem makeZpMenuItemWithImageName:@"bizicon_store_n" title:@"门店"];
        ZPPopoverItem *popoverItem3 = [ZPPopoverItem makeZpMenuItemWithImageName:@"bizicon_news_n" title:@"资讯"];
        ZPPopover *popover = [ZPPopover popoverWithTopPointInWindow:CGPointMake(barBtnX, barBtnY) items:@[popoverItem1,popoverItem2,popoverItem3]];
        popover.delegate = self;
        
        _popover = popover;
    }
    return _popover;
}

- (SearchHotKeywordsView *)searchHotKeywordsView{
    if (!_searchHotKeywordsView) {
        _searchHotKeywordsView = [[SearchHotKeywordsView alloc]init];
        _searchHotKeywordsView.delegate = self;
    }
    return _searchHotKeywordsView;
}

- (UIView *)sectionHeaderView{
    
    if (!_sectionHeaderView) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SectionHeaderViewHight)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UILabel *tipLabel = [[UILabel alloc]initWithFrame:view.bounds];
        tipLabel.font = [UIFont boldSystemFontOfSize:15];
        tipLabel.text = @"   历史搜索";
        tipLabel.textColor = [UIColor darkGrayColor];
        tipLabel.backgroundColor = [UIColor whiteColor];
        [view addSubview:tipLabel];
        
        CGFloat line_h = LINE_H;
        CGFloat line_y = CGRectGetHeight(view.frame)-line_h;
        CGFloat line_w =  CGRectGetWidth(view.frame);
        CGFloat line_x = 0;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(line_x, line_y, line_w, line_h)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [view addSubview:line];
        
        _sectionHeaderView = view;
    }
    return _sectionHeaderView;
}

- (UIView *)sectionFooterView{
    
    if (!_sectionFooterView) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SectionFooterViewHight)];
        view.backgroundColor = [UIColor whiteColor];
        
        CGFloat btn_w = 200;
        CGFloat btn_h = 40;
        CGFloat btn_x = (CGRectGetWidth(view.frame)-btn_w)*0.5;
        CGFloat btn_y = (CGRectGetHeight(view.frame)-btn_h)*0.5;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btn_x, btn_y, btn_w, btn_h)];
        [view addSubview:btn];
        [btn addTarget:self action:@selector(cleanUpHistory) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"清空历史搜索" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 8;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = LINE_H;
        btn.layer.masksToBounds = YES;
        
        _sectionFooterView = view;
    }
    
    return _sectionFooterView;
}

#pragma mark - set

- (void)setSearchHotKeywordsModel:(SearchHotKeywordsModel *)searchHotKeywordsModel{
    _searchHotKeywordsModel = searchHotKeywordsModel;
    self.searchTypeItemsArray = [SearchTypeItem searchTypeItemArrayWith:searchHotKeywordsModel];
}

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.backgroundColor = [UIColor whiteColor];
    [tableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:reuseIdentifier];
    
    [self buildNavigationBar];
    
    //历史搜索
    self.searchHistoryKeywordsModel = [SearchHistoryKeywordsManager shareSearchHistoryKeywordsManager].model;
    
    //热门关键字
    self.searchHotKeywordsModel = [SearchHotKeywordsManager shareSearchHotKeywordsManager].model;
    
    //默认选择服务
    [self didSelectMenuItemAtIndex:0];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.textField resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.textField.isFirstResponder) [self.textField becomeFirstResponder];
}


#pragma mark - private

- (void)buildNavigationBar{
    
    self.navigationItem.titleView = self.textField;
    [self.textField becomeFirstResponder];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"搜索" postion:UIBarButtonPositionRight target:self action:@selector(search)];
}

/**
 *  开始搜索 - 普通文本搜索
 */
- (void)search{
    [self addSearchHistoryKeywords];
    SearchHotKeywordsListItem *item = nil;
    if (self.textField.text.length==0 &&
        self.currentSearchHotKeywordsList.count>0)
    {
        item = self.currentSearchHotKeywordsList[0];
    }
    [self searchWithItem:item];
}

/**
 *  开始搜索
 */
- (void)searchWithItem:(SearchHotKeywordsListItem *)item{
    if (!self.popover.hidden) [self.popover hide];
    if (self.textField.isFirstResponder) [self.textField resignFirstResponder];
    
    SearchResultViewController *controller = [[SearchResultViewController alloc]init];
    controller.searchParmsModel = [self searchParmsModelWithItem:item];
    controller.searchType = self.currentSearchType;
    [self.navigationController pushViewController:controller animated:YES];
}

- (SearchParmsModel *)searchParmsModelWithItem:(SearchHotKeywordsListItem *)item{
    SearchParmsModel *searchParmsModel = nil;
    SearchType searchType = self.currentSearchType;
    switch (searchType) {
        case SearchType_Product:
        case SearchType_Store:
        {
            SearchParmsProductOrStoreModel *searchParmsProductOrStoreModel = nil;
            if (item) {
                SearchHotKeywordsListProductOrStoreItem *productOrStoreItem = (SearchHotKeywordsListProductOrStoreItem *)item;
                searchParmsProductOrStoreModel = productOrStoreItem.search_parms;
            }else{
                searchParmsProductOrStoreModel = [[SearchParmsProductOrStoreModel alloc]init];
                searchParmsProductOrStoreModel.k = self.textField.text;
            }
            searchParmsModel = searchParmsProductOrStoreModel;
        }
            break;
        case SearchType_Article:
        {
            SearchParmsArticleModel *searchParmsArticleModel = nil;
            if (item) {
                SearchHotKeywordsListArticleItem *articleItem = (SearchHotKeywordsListArticleItem *)item;
                searchParmsArticleModel = articleItem.search_parms;
            }else{
                searchParmsArticleModel = [[SearchParmsArticleModel alloc]init];
                searchParmsArticleModel.k = self.textField.text;
            }
            searchParmsModel = searchParmsArticleModel;
        }
            break;
    }
    return searchParmsModel;
}

/**
 *  获取当前搜索类型Item
 *
 *  @return 当前搜索类型Item
 */
- (SearchTypeItem *)currentSearchTypeItem{
    SearchTypeItem *item = nil;
    NSUInteger index = self.currentSearchSelectedIndex;
    if (self.searchTypeItemsArray.count>index) {
        item = self.searchTypeItemsArray[index];
    }
    return item;
}

/**
 *  获取当前搜索类型type
 *
 *  @return 当前搜索类型type
 */
- (SearchType)currentSearchType{
    return self.currentSearchTypeItem.searchType;
}

/**
 *  获取当前热门搜索关键词列表
 *
 *  @return 当前热门搜索关键词列表
 */
- (NSArray<SearchHotKeywordsListItem *> *)currentSearchHotKeywordsList{
    
    NSArray<SearchHotKeywordsListItem *> *searchHotKeywordsList = nil;
    SearchHotKeywordsData *data = self.searchHotKeywordsModel.data;
    switch (self.currentSearchType) {
        case SearchType_Product:
        {
            searchHotKeywordsList = data.product;
        }
            break;
        case SearchType_Store:
        {
            searchHotKeywordsList = data.store;
        }
            break;
        case SearchType_Article:
        {
            searchHotKeywordsList = data.article;
        }
            break;
        default:
            break;
    }
    return searchHotKeywordsList;
}

/**
 *  获取当前历史搜索关键词列表
 *
 *  @return 当前历史搜索关键词列表
 */
- (NSMutableArray<NSString *> *)currentSearchHistoryKeywordsList {
    
    NSMutableArray<NSString *> *searchHistoryKeywordsList = nil;
    
    switch (self.currentSearchType) {
        case SearchType_Product:
        {
            searchHistoryKeywordsList = self.searchHistoryKeywordsModel.product;
        }
            break;
        case SearchType_Store:
        {
            searchHistoryKeywordsList = self.searchHistoryKeywordsModel.store;
        }
            break;
        case SearchType_Article:
        {
            searchHistoryKeywordsList = self.searchHistoryKeywordsModel.article;
        }
            break;
        default:
            break;
    }
    return searchHistoryKeywordsList;
}

/**
 *  设置搜索提示标题
 */
- (void)reSetSearchTips{
    self.textField.searchTypeItem = self.currentSearchTypeItem;
}
/**
 *  设置热门搜索关键词视图
 */
- (void)reSetSearchHotKeywordsView{
    
    NSArray<SearchHotKeywordsListItem *> *list = self.currentSearchHotKeywordsList;
    if (list.count>0) {
        [self.searchHotKeywordsView setSearchHotKeywordsList:list hasSearchHistory:self.currentSearchHistoryKeywordsList.count>0];
        self.tableView.tableHeaderView = self.searchHotKeywordsView;
    }else{
        self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    }
}

/**
 *  添加历史搜索关键词
 */
- (void)addSearchHistoryKeywords{
    [[SearchHistoryKeywordsManager shareSearchHistoryKeywordsManager] addSearchHistoryKeywords:self.textField.text
                                                               searchType:self.currentSearchType];
    [self reSetSearchHotKeywordsView];
    [self.tableView reloadData];
}
/**
 *  清除历史搜索记录
 */
- (void)cleanUpHistory{
    [[SearchHistoryKeywordsManager shareSearchHistoryKeywordsManager] cleanUpHistoryWithSearchType:self.currentSearchType];
    [self reSetSearchHotKeywordsView];
    [self.tableView reloadData];
}


#pragma mark - ZPPopoverDelegate

- (void)didSelectMenuItemAtIndex:(NSUInteger)index{
    self.currentSearchSelectedIndex = index;
    [self reSetSearchTips];
    [self reSetSearchHotKeywordsView];
    [self.tableView reloadData];
}


#pragma mark - SearchHotKeywordsViewDelegate
/**
 *  开始搜索 - 热搜关键字搜索
 */
- (void)searchHotKeywordsView:(SearchHotKeywordsView *)searchHotKeywordsView didClickBtnIndex:(NSUInteger)index{
    [self searchWithItem:self.currentSearchHotKeywordsList[index]];
}

#pragma mark - SearchTableViewCellDelegate

- (void)searchTableViewCell:(SearchTableViewCell *)searchTableViewCell didClickOnDelegateBtn:(NSUInteger)index{
    
    [[SearchHistoryKeywordsManager shareSearchHistoryKeywordsManager] removeSearchHistoryKeywordsAtIndex:index
                                                                         searchType:self.currentSearchType];
    [self reSetSearchHotKeywordsView];
    [self.tableView reloadData];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self search];
    return false;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentSearchHistoryKeywordsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SectionHeaderViewHight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SectionFooterViewHight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.currentSearchHistoryKeywordsList.count>0?self.sectionHeaderView:nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.currentSearchHistoryKeywordsList.count>0?self.sectionFooterView:nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    NSMutableArray<NSString *> *list = self.currentSearchHistoryKeywordsList;
    cell.keywordsLabel.text = list[indexPath.row];
    cell.delegate = self;
    cell.deleteBtn.tag = indexPath.row;
    cell.lineLeadingConstraint.constant = (indexPath.row == (list.count-1))?0:12;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.textField.text = self.currentSearchHistoryKeywordsList[indexPath.row];
    [self search];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
