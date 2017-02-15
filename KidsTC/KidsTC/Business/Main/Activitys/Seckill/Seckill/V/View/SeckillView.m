//
//  SeckillView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillView.h"
#import "KTCEmptyDataView.h"

#import "SeckillSlider.h"
#import "SeckillToolBar.h"

#import "SeckillBaseCell.h"
#import "SeckillBannerCell.h"
#import "SeckillSmallCell.h"
#import "SeckillLargeCell.h"

static NSString *const BaseCellID = @"SeckillBaseCell";
static NSString *const BannerCellID = @"SeckillBannerCell";
static NSString *const SmallCellID = @"SeckillSmallCell";
static NSString *const LargeCellID = @"SeckillLargeCell";

@interface SeckillView ()<UITableViewDelegate,UITableViewDataSource,SeckillBaseCellDelegate,SeckillSliderDelegate,SeckillToolBarDelegate>
@property (weak, nonatomic) IBOutlet SeckillSlider *slider;



@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SeckillToolBar *tooBar;

@end

@implementation SeckillView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSlider];
    [self setupTableView];
    [self setupToolBar];
}

- (void)setTimeData:(SeckillTimeData *)timeData {
    _timeData = timeData;
    self.slider.timeData = timeData;
    self.tooBar.timeData = timeData;
}

- (void)setDataData:(SeckillDataData *)dataData {
    _dataData = dataData;
    self.slider.dataData = dataData;
    self.tooBar.dataData = dataData;
    [self.tableView reloadData];
    
    if (self.dataData.items.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:self.tableView.bounds
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - setupTableView

- (void)setupTableView {
    self.tableView.estimatedRowHeight = 66;
    [self registerCells];
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"SeckillBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"SeckillBannerCell" bundle:nil] forCellReuseIdentifier:BannerCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"SeckillSmallCell" bundle:nil] forCellReuseIdentifier:SmallCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"SeckillLargeCell" bundle:nil] forCellReuseIdentifier:LargeCellID];
}

- (NSString *)cellIdWithType:(SeckillDataItemShowType)type {
    switch (type) {
        case SeckillDataItemShowTypeSmall:
        {
            return SmallCellID;
        }
            break;
        case SeckillDataItemShowTypeLarge:
        {
            return LargeCellID;
        }
            break;
        case SeckillDataItemShowTypeBanner:
        {
            return BannerCellID;
        }
            break;
        default:
        {
            return BaseCellID;
        }
            break;
    }
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataData.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSArray<SeckillDataItem *> *items = self.dataData.items;
    if (row<items.count) {
        SeckillDataItem *item = items[row];
        NSString *cellID = [self cellIdWithType:item.type];
        SeckillBaseCell *cell = [self cellWithID:cellID];
        cell.item = item;
        cell.delegate = self;
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    NSArray<SeckillDataItem *> *items = self.dataData.items;
    if (row<items.count) {
        SeckillDataItem *item = items[row];
        if ([self.delegate respondsToSelector:@selector(seckillView:actionType:value:)]) {
            [self.delegate seckillView:self actionType:SeckillViewActionTypeSegue value:item.segueModel];
        }
    }
}

#pragma mark SeckillBaseCellDelegate

- (void)seckillBaseCell:(SeckillBaseCell *)cell actionType:(SeckillBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(seckillView:actionType:value:)]) {
        [self.delegate seckillView:self actionType:(SeckillViewActionType)type value:value];
    }
}

#pragma mark - setupSlider

- (void)setupSlider {
    self.slider.hidden = YES;
    self.slider.delegate = self;
}

#pragma mark SeckillSliderDelegate

- (void)seckillSlider:(SeckillSlider *)slider didSelectTimeItem:(SeckillTimeTime *)time {
    if ([self.delegate respondsToSelector:@selector(seckillView:actionType:value:)]) {
        [self.delegate seckillView:self actionType:SeckillViewActionTypeSeckillTime value:time];
    }
}

- (void)seckillSliderCountDownOver:(SeckillSlider *)slider {
    if ([self.delegate respondsToSelector:@selector(seckillView:actionType:value:)]) {
        [self.delegate seckillView:self actionType:SeckillViewActionTypeCountDownOver value:nil];
    }
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    self.tooBar.hidden = YES;
    self.tooBar.delegate = self;
}

#pragma mark SeckillToolBarDelegate

- (void)seckillToolBar:(SeckillToolBar *)toolBar actionType:(SeckillTimeToolBarItemActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(seckillView:actionType:value:)]) {
        [self.delegate seckillView:self actionType:(SeckillViewActionType)type value:value];
    }
}

@end
