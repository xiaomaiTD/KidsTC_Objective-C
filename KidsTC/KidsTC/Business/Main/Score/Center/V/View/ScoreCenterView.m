//
//  ScoreCenterView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreCenterView.h"

#import "ScoreCenterBaseCell.h"
#import "ScoreCenterCenterCell.h"
#import "ScoreCenterItemsCell.h"
#import "ScoreCenterDetailCell.h"
#import "ScoreCenterDetailTopCell.h"

static NSString *const BaseCellID = @"ScoreCenterBaseCell";
static NSString *const CenterCellID = @"ScoreCenterCenterCell";
static NSString *const ItemsCellID = @"ScoreCenterItemsCell";
static NSString *const DetailCellID = @"ScoreCenterDetailCell";
static NSString *const DetailTopCellID = @"ScoreCenterDetailTopCell";

@interface ScoreCenterView ()<UITableViewDelegate,UITableViewDataSource,ScoreCenterBaseCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray<NSArray<ScoreCenterBaseCell *> *> *sections;
@end

@implementation ScoreCenterView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.estimatedRowHeight = 80;
    [self registerCells];
}

- (void)setRecords:(NSArray<ScoreRecordItem *> *)records {
    _records = records;
    [self reloadData];
}

- (void)reloadData {
    [self setupSections];
    [self.tableView reloadData];
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreCenterBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreCenterCenterCell" bundle:nil] forCellReuseIdentifier:CenterCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreCenterItemsCell" bundle:nil] forCellReuseIdentifier:ItemsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreCenterDetailCell" bundle:nil] forCellReuseIdentifier:DetailCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreCenterDetailTopCell" bundle:nil] forCellReuseIdentifier:DetailTopCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    NSMutableArray *sections = [NSMutableArray array];
    NSMutableArray *section01 = [NSMutableArray array];
    ScoreCenterCenterCell *centerCell = [self cellWithID:CenterCellID];
    if (centerCell) [section01 addObject:centerCell];
    ScoreCenterItemsCell *itemsCell = [self cellWithID:ItemsCellID];
    if (itemsCell) [section01 addObject:itemsCell];
    if (section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    ScoreCenterDetailTopCell *detailTopCell = [self cellWithID:DetailTopCellID];
    if (detailTopCell) [section02 addObject:detailTopCell];
    [self.records enumerateObjectsUsingBlock:^(ScoreRecordItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ScoreCenterDetailCell *detailCell = [self cellWithID:DetailCellID];
        detailCell.record = obj;
        if (detailCell) [section02 addObject:detailCell];
    }];
    if (section02.count>0) [sections addObject:section02];
    self.sections = [NSArray arrayWithArray:sections];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.sections.count) {
        return self.sections[section].count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section==self.sections.count-1)?CGFLOAT_MIN:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<ScoreCenterBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            ScoreCenterBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.userInfoData = self.userInfoData;
            return cell;
        }
    }
    return [self cellWithID:BaseCellID];
}

#pragma mark ScoreCenterBaseCellDelegate

- (void)scoreCenterBaseCell:(ScoreCenterBaseCell *)cell actionType:(ScoreCenterBaseCellActionType)type vlaue:(id)value {
    if ([self.delegate respondsToSelector:@selector(scoreCenterView:actionType:vlaue:)]) {
        [self.delegate scoreCenterView:self actionType:(ScoreCenterViewActionType)type vlaue:value];
    }
}

@end
