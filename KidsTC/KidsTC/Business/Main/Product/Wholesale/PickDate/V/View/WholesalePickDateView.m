//
//  WholesalePickDateView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesalePickDateView.h"
#import "WholesalePickDateToolBar.h"

#import "WholesalePickDateBaseCell.h"
#import "WholesalePickDateTitleCell.h"
#import "WholesalePickDateTimeCell.h"
#import "WholesalePickDatePlaceCell.h"

static NSString *BaseCellID = @"WholesalePickDateBaseCell";
static NSString *TitleCellID = @"WholesalePickDateTitleCell";
static NSString *TimeCellID = @"WholesalePickDateTimeCell";
static NSString *PlaceCellID = @"WholesalePickDatePlaceCell";

static CGFloat const animationDuration = 0.2;

@interface WholesalePickDateView ()<UITableViewDelegate,UITableViewDataSource,WholesalePickDateBaseCellDelegate,WholesalePickDateToolBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet WholesalePickDateToolBar *toolBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;

@property (nonatomic, strong) NSArray<NSArray<WholesalePickDateBaseCell *> *> *sections;

@end

@implementation WholesalePickDateView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.estimatedRowHeight = 200;
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesalePickDateBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesalePickDateTitleCell" bundle:nil] forCellReuseIdentifier:TitleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesalePickDateTimeCell" bundle:nil] forCellReuseIdentifier:TimeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesalePickDatePlaceCell" bundle:nil] forCellReuseIdentifier:PlaceCellID];
    
    self.toolBar.delegate = self;
    
    [self layoutIfNeeded];
    self.backgroundColor = [UIColor clearColor];
    self.bottomMargin.constant = - CGRectGetHeight(self.contentView.frame);
    [self layoutIfNeeded];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(wholesalePickDateView:actionType:value:)]) {
        [self.delegate wholesalePickDateView:self actionType:WholesalePickDateViewActionTypeTouchBegin value:nil];
    }
}

- (void)setSku:(WholesalePickDateSKU *)sku {
    _sku = sku;
    self.toolBar.type = sku.type;
    [self setupSections];
    [self.tableView reloadData];
}

- (void)setupSections {
    NSMutableArray *sections = [NSMutableArray array];
    if (self.sku.times.count>0 && self.sku.isShowTime) {
        NSMutableArray *section00 = [NSMutableArray array];
        
        WholesalePickDateTitleCell *titleCell = [self cellWithID:TitleCellID];
        titleCell.title = @"选择时间";
        if (titleCell) [section00 addObject:titleCell];
        
        WholesalePickDateTimeCell *timeCell = [self cellWithID:TimeCellID];
        if (timeCell) [section00 addObject:timeCell];
        if (section00.count>0) [sections addObject:section00];
    }
    if (self.sku.places.count>0) {
        NSMutableArray *section01 = [NSMutableArray array];
        
        WholesalePickDateTitleCell *titleCell = [self cellWithID:TitleCellID];
        titleCell.title = @"选择地址";
        if (titleCell) [section01 addObject:titleCell];
        
        WholesalePickDatePlaceCell *placeCell = [self cellWithID:PlaceCellID];
        if (placeCell) [section01 addObject:placeCell];
        if (section01.count>0) [sections addObject:section01];
    }
    self.sections = [NSArray arrayWithArray:sections];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellId {
    return [self.tableView dequeueReusableCellWithIdentifier:cellId];
}

- (void)show {
    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.bottomMargin.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (void)hide:(void(^)(BOOL finish))completionBlock {
    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.bottomMargin.constant = - CGRectGetHeight(self.contentView.frame);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completionBlock) completionBlock(finished);
    }];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<WholesalePickDateBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            WholesalePickDateBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.sku = self.sku;
            return cell;
        }
    }
    return [self cellWithID:BaseCellID];
}

#pragma mark - WholesalePickDateBaseCellDelegate

- (void)wholesalePickDateBaseCell:(WholesalePickDateBaseCell *)cell actionType:(WholesalePickDateBaseCellActionType)type vlaue:(id)value {
    switch (type) {
        case WholesalePickDateBaseCellActionTypeSelectTiem:
        {
            self.toolBar.time = value;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - WholesalePickDateToolBarDelegate

- (void)wholesalePickDateToolBar:(WholesalePickDateToolBar *)toolBar actionType:(WholesalePickDateToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(wholesalePickDateView:actionType:value:)]) {
        [self.delegate wholesalePickDateView:self actionType:(WholesalePickDateViewActionType)type value:value];
    }
}

@end
