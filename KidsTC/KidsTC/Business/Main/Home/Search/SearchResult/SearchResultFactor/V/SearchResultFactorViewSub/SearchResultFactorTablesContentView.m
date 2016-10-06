//
//  SearchResultFactorTablesContentView.m
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultFactorTablesContentView.h"
#import "SearchResultFactorTableViewCell.h"
#define ROW_HEIGHT 40
#define SECTION_HEIGHT 12
#define HEADER_FOOTER_HEIGHT 0.01
#define FILTER_MIN_ROW 6 //筛选类目tableViewV1最低的高度行数

@interface SearchResultFactorTablesContentView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableViewV1;
@property (nonatomic, strong) UITableView *tableViewV2;
@property (nonatomic, strong) NSIndexPath *tableViewV1_selectedIndexPath;
@property (nonatomic, strong) NSIndexPath *tableViewV2_selectedIndexPath;
@end
static NSString *reuseIdentifier = @"SearchResultFactorTableViewCell";
@implementation SearchResultFactorTablesContentView

#pragma mark - lazy load

- (UITableView *)tableViewV1{
    if (!_tableViewV1) {
        _tableViewV1 = self.tableView;
        [self addSubview:_tableViewV1];
    }
    return _tableViewV1;
}

- (UITableView *)tableViewV2{
    if (!_tableViewV2) {
        _tableViewV2 = self.tableView;
        [self addSubview:_tableViewV2];
    }
    return _tableViewV2;
}

- (NSIndexPath *)tableViewV1_selectedIndexPath{
    if (!_tableViewV1_selectedIndexPath) {
        _tableViewV1_selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _tableViewV1_selectedIndexPath;
}

- (NSIndexPath *)tableViewV2_selectedIndexPath{
    if (!_tableViewV2_selectedIndexPath) {
        _tableViewV2_selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _tableViewV2_selectedIndexPath;
}

#pragma mark - set

- (void)setItem:(SearchResultFactorTopItem *)item{
    if (_item) {
        [self operateDataWith:TablesContentViewOperaDataType_UndoSelected];
    }
    _item = item;
    
    self.tableViewV1_selectedIndexPath = [SearchResultFactorItem firstSelectedSubItemIndexPath:item];
    self.tableViewV2_selectedIndexPath = [SearchResultFactorItem firstSelectedSubItemIndexPath:self.tableViewV1_selectedItem];
    
    [self layoutSubviews];
    
    [self reloadData];
}

- (void)scrollToFirstSelectedItem{

    [self.tableViewV1 scrollToRowAtIndexPath:self.tableViewV1_selectedIndexPath
                            atScrollPosition:UITableViewScrollPositionMiddle
                                    animated:YES];
    switch (self.item.type) {
        case SearchResultFactorTopItemTypeFilter:
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableViewV2 scrollToRowAtIndexPath:self.tableViewV2_selectedIndexPath
                                        atScrollPosition:UITableViewScrollPositionMiddle
                                                animated:YES];
            });
        }
            break;
        default:
            break;
    }
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    switch (self.item.type) {
        case SearchResultFactorTopItemTypeArea:
        case SearchResultFactorTopItemTypeSort:
        {
            self.tableViewV1.frame = self.bounds;
            self.tableViewV2.hidden = YES;
        }
            break;
            
        case SearchResultFactorTopItemTypeFilter:
        {
            CGFloat self_w = CGRectGetWidth(self.frame);
            CGFloat self_h = CGRectGetHeight(self.frame);
            
            CGFloat ratio = 1.0/3;
            CGFloat tableViewV1_w = self_w * ratio;
            CGFloat tableViewV2_w = self_w * (1-ratio);
            
            self.tableViewV1.frame = CGRectMake(0, 0, tableViewV1_w, self_h);
            self.tableViewV2.frame = CGRectMake(tableViewV1_w, 0, tableViewV2_w, self_h);
            self.tableViewV2.hidden = NO;
        }
            break;
    }
}

#pragma mark - get

/**
 *  获取tabView
 *
 *  @return tabView
 */
- (UITableView *)tableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
    tableView.backgroundColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"SearchResultFactorTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseIdentifier];
    return tableView;
}

/**
 *  获取tabViewV1选中的Item
 *
 *  @return tabViewV1选中的Item
 */
- (SearchResultFactorItem *)tableViewV1_selectedItem{
    NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = self.item.subArrays;
    NSIndexPath *indexPath = self.tableViewV1_selectedIndexPath;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    SearchResultFactorItem *item = subArrays[section][row];
    return item;
}

/**
 *  获取tableViewV2的指定IndexPath的item
 *
 *  @param indexPath 指定的IndexPath
 *
 *  @return tableViewV2的指定IndexPath的item
 */
- (SearchResultFactorItem *)tableViewV2ItemWithIndexPath:(NSIndexPath *)indexPath{
    NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = self.tableViewV1_selectedItem.subArrays;
    SearchResultFactorItem *item = subArrays[indexPath.section][indexPath.row];
    return item;
}



/**
 *  获取tabViewContentHeight
 *
 *  @return tabViewContentHeight
 */
- (CGFloat)contentHeight{
    
    CGFloat height = 0;
    switch (self.item.type) {
        case SearchResultFactorTopItemTypeArea:
        case SearchResultFactorTopItemTypeSort:
        {
            height = self.tableViewV1.contentSize.height;
        }
            break;
            
        case SearchResultFactorTopItemTypeFilter:
        {
            height = self.tableViewV1.contentSize.height;
            CGFloat headerCount = self.item.subArrays.count-1;
            headerCount = headerCount<0?0:headerCount;
            CGFloat minHeight = FILTER_MIN_ROW*ROW_HEIGHT + SECTION_HEIGHT*headerCount + 2*HEADER_FOOTER_HEIGHT;
            height = height<minHeight?minHeight:height;
        }
            break;
    }
    return height;
}

- (void)reloadData{
    [self.tableViewV1 reloadData];
    if (self.item.type == SearchResultFactorTopItemTypeFilter) [self.tableViewV2 reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSUInteger sectionCount = 0;
    if (tableView == self.tableViewV1) {
        sectionCount = self.item.subArrays.count;
    }else if (tableView == self.tableViewV2) {
        sectionCount = self.tableViewV1_selectedItem.subArrays.count;
    }
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray<SearchResultFactorItem *> *subItems = nil;
    if (tableView == self.tableViewV1) {
        subItems = self.item.subArrays[section];
    }else if (tableView == self.tableViewV2) {
        subItems = self.tableViewV1_selectedItem.subArrays[section];
    }
    return subItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = SECTION_HEIGHT;
    if (section==0) height = HEADER_FOOTER_HEIGHT;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return HEADER_FOOTER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ROW_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchResultFactorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    NSArray<SearchResultFactorItem *> *subItems = nil;
    if (tableView == self.tableViewV1) {
        subItems = self.item.subArrays[indexPath.section];
    }else if (tableView == self.tableViewV2) {
        subItems = self.tableViewV1_selectedItem.subArrays[indexPath.section];
    }
    SearchResultFactorItem *item = subItems[indexPath.row];
    cell.item = item;
    
    [self dealWithShowStyleForCell:cell item:item tableView:tableView indexPath:indexPath];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.item.type) {
        case SearchResultFactorTopItemTypeArea:
        case SearchResultFactorTopItemTypeSort:
        {
            [self dealWithShowDataUnderItem:self.item
                                  tableView:tableView
                                  indexPath:indexPath
                                 toSelected:YES
                         toMakeSureSelected:YES];
            [self makeSureData];
        }
            break;
            
        case SearchResultFactorTopItemTypeFilter:
        {
            if (tableView == self.tableViewV1) {
                self.tableViewV1_selectedIndexPath = indexPath;
                [tableView reloadData];
                [self.tableViewV2 reloadData];
            }else if (tableView == self.tableViewV2){
                SearchResultFactorItem *item =[self tableViewV2ItemWithIndexPath:indexPath];
                BOOL toSelected = !item.isSelected;
                [self dealWithShowDataUnderItem:self.item
                                      tableView:self.tableViewV1
                                      indexPath:self.tableViewV1_selectedIndexPath
                                     toSelected:toSelected
                             toMakeSureSelected:NO];
                [self dealWithShowDataUnderItem:self.tableViewV1_selectedItem
                                      tableView:tableView
                                      indexPath:indexPath
                                     toSelected:toSelected
                             toMakeSureSelected:NO];
                self.tableViewV2_selectedIndexPath = indexPath;
            }
        }
            break;
    }
}

#pragma mark - 处理样式

- (void)dealWithShowStyleForCell:(SearchResultFactorTableViewCell *)cell
                            item:(SearchResultFactorItem *)item
                       tableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath{
    
    switch (self.item.type) {
        case SearchResultFactorTopItemTypeArea:
        case SearchResultFactorTopItemTypeSort:
        {
            cell.accessoryImageView.hidden = YES;
            cell.leftTip.hidden = YES;
            cell.rightTip.hidden = YES;
            [cell setSelfDefineSelected:item.isSelected animated:YES];
        }
            break;
            
        case SearchResultFactorTopItemTypeFilter:
        {
            if (tableView == self.tableViewV1) {
                cell.accessoryImageView.hidden = YES;
                cell.leftTip.hidden = !item.isSelected;
                cell.rightTip.hidden = !(self.tableViewV1_selectedIndexPath == indexPath);
                [cell setSelfDefineSelected:item.isSelected animated:YES];
            }else if (tableView == self.tableViewV2){
                cell.accessoryImageView.hidden = NO;
                NSString *accessoryImageName = item.isSelected?@"select_yes":@"select_no";
                cell.accessoryImageView.image = [UIImage imageNamed:accessoryImageName];
                cell.leftTip.hidden = YES;
                cell.rightTip.hidden = YES;
                [cell setSelfDefineSelected:item.isSelected animated:YES];
            }
        }
            break;
    }
}

#pragma mark - 处理数据

- (void)dealWithShowDataUnderItem:(SearchResultFactorItem *)item
                        tableView:(UITableView *)tableView
                        indexPath:(NSIndexPath *)indexPath
                       toSelected:(BOOL)toSelected
               toMakeSureSelected:(BOOL)makeSureSelected{
    
    NSArray<SearchResultFactorItem *> *subItems = item.subArrays[indexPath.section];
    [subItems enumerateObjectsUsingBlock:^(SearchResultFactorItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.selected) {
            if (obj.subArrays.count>0) {
                [self dealWithShowDataUnderItem:obj
                                      tableView:nil
                                      indexPath:[NSIndexPath indexPathForRow:-1 inSection:0]
                                     toSelected:NO
                             toMakeSureSelected:makeSureSelected];
            }
        }
        
        if (toSelected) {
            obj.selected = indexPath.row == idx;
        }else{
            obj.selected = NO;
        }
        
        if (makeSureSelected) {
            obj.makeSureSelected = obj.selected;
        }else{
            //obj.makeSureSelected = NO;
        }
    }];
    if (tableView) {
        [tableView reloadData];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}


- (void)makeSureData{
    if ([self.delegate respondsToSelector:@selector(tablesContentViewDidMakeSureData:)]) {
        [self.delegate tablesContentViewDidMakeSureData:self];
    }
}


- (void)operateDataWith:(TablesContentViewOperaDataType)type{
    [self operateDataWith:self.item type:type];
}

- (void)operateDataWith:(SearchResultFactorItem *)item type:(TablesContentViewOperaDataType)type{
    
    NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = item.subArrays;
    switch (type) {
        case TablesContentViewOperaDataType_CleanUpSelected:
        {
            item.selected = NO;
        }
            break;
        case TablesContentViewOperaDataType_UndoSelected:
        {
            item.selected = item.makeSureSelected;
        }
            break;
        case TablesContentViewOperaDataType_MakeSureSelected:
        {
            item.makeSureSelected = item.selected;
        }
            break;
    }
    [subArrays enumerateObjectsUsingBlock:^(NSArray<SearchResultFactorItem *> * _Nonnull rowArray, NSUInteger idx, BOOL * _Nonnull stop) {
        [rowArray enumerateObjectsUsingBlock:^(SearchResultFactorItem * _Nonnull subItem, NSUInteger idx, BOOL * _Nonnull stop) {
            [self operateDataWith:subItem type:type];
        }];
    }];
}

@end
