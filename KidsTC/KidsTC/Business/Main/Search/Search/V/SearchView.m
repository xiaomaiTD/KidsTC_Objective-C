//
//  SearchView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchView.h"
#import "Colours.h"
#import "NSString+Category.h"

#import "SearchModel.h"

#import "SearchSectionItem.h"

#import "SearchSectionHeader.h"
#import "SearchHotKeyCell.h"
#import "SearchHistoryCell.h"
#import "SearchTableViewFooter.h"

static NSString *const SectionHeaderID = @"SearchSectionHeader";
static NSString *const CellID = @"UITableViewCell";
static NSString *const HotKeyCellID = @"SearchHotKeyCell";
static NSString *const HistoryCellID = @"SearchHistoryCell";

@interface SearchView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<SearchSectionItem *> *sections;
@property (nonatomic, strong) SearchTableViewFooter *footer;
@end

@implementation SearchView

- (SearchTableViewFooter *)footer {
    if (!_footer) {
        _footer = [[NSBundle mainBundle] loadNibNamed:@"SearchTableViewFooter" owner:self options:nil].firstObject;
        _footer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
        WeakSelf(self)
        _footer.actionBlock = ^{
            StrongSelf(self)
            if ([self.delegate respondsToSelector:@selector(searchView:actionType:value:)]) {
                [self.delegate searchView:self actionType:SearchViewActionTypeCleanUpHistory value:nil];
            }
        };
    }
    return _footer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTableView];
        
        [self reloadData];
    }
    return self;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 49;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [tableView registerNib:[UINib nibWithNibName:@"SearchSectionHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:SectionHeaderID];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    [tableView registerNib:[UINib nibWithNibName:@"SearchHotKeyCell" bundle:nil] forCellReuseIdentifier:HotKeyCellID];
    [tableView registerNib:[UINib nibWithNibName:@"SearchHistoryCell" bundle:nil] forCellReuseIdentifier:HistoryCellID];
    [self addSubview:tableView];
    self.tableView = tableView;
}

- (void)reloadData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.sections = [SearchModel shareSearchModel].sections;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([SearchModel shareSearchModel].isHasHistory) {
                self.tableView.tableFooterView = self.footer;
            }else{
                self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.001)];
            }
            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.sections.count) {
        SearchSectionItem *sectionItem = self.sections[section];
        return sectionItem.rows.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section<self.sections.count) {
        SearchSectionItem *sectionItem = self.sections[section];
        if ([sectionItem.title isNotNull]) {
            return 49;
        }
    }
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SearchSectionHeader *sectionHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderID];
    if (section<self.sections.count) {
        SearchSectionItem *sectionItem = self.sections[section];
        sectionHeader.title = sectionItem.title;
    }
    return sectionHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        SearchSectionItem *sectionItem = self.sections[section];
        NSArray<SearchRowItem *> *rows = sectionItem.rows;
        if (row<rows.count) {
            SearchRowItem *rowItem = rows[row];
            switch (rowItem.type) {
                case SearchRowItemTypeHotKey:
                {
                    SearchHotKeyCell *hotKeyCell = [tableView dequeueReusableCellWithIdentifier:HotKeyCellID];
                    hotKeyCell.rowItem = rowItem;
                    hotKeyCell.actionBlock = ^(SearchHotKeywordsItem *item){
                        if ([self.delegate respondsToSelector:@selector(searchView:actionType:value:)]) {
                            [self.delegate searchView:self actionType:SearchViewActionTypeDidSelectItem value:item];
                        }
                    };
                    cell = hotKeyCell;
                }
                    break;
                case SearchRowItemTypeLocal:
                {
                    SearchHistoryCell *historyCell = [tableView dequeueReusableCellWithIdentifier:HistoryCellID];
                    historyCell.rowItem = rowItem;
                    historyCell.actionBlock = ^(SearchHotKeywordsItem *item){
                        if ([self.delegate respondsToSelector:@selector(searchView:actionType:value:)]) {
                            [self.delegate searchView:self actionType:SearchViewActionTypeDidSelectItem value:item];
                        }
                    };
                    cell = historyCell;
                }
                    break;
                default:
                    break;
            }
        }
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        SearchSectionItem *sectionItem = self.sections[section];
        NSArray<SearchRowItem *> *rows = sectionItem.rows;
        if (row<rows.count) {
            SearchRowItem *rowItem = rows[row];
            if (rowItem.type == SearchRowItemTypeLocal) {
                return YES;
            }
        }
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([self.delegate respondsToSelector:@selector(searchView:actionType:value:)]) {
            [self.delegate searchView:self actionType:SearchViewActionTypeDeleteHistoryItem value:@(indexPath.row)];
        }
    }
}


@end
