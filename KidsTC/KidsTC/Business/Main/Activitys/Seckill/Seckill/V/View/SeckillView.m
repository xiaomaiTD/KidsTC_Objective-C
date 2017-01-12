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
@property (nonatomic, strong) SeckillSlider *slider;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SeckillToolBar *tooBar;
@end

@implementation SeckillView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSlider];
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
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

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSeckillSliderH, SCREEN_WIDTH, CGRectGetHeight(self.bounds)-kSeckillSliderH-kSeckillToolBarH) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 66;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
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
    SeckillSlider *slider = [[NSBundle mainBundle] loadNibNamed:@"SeckillSlider" owner:self options:nil].firstObject;
    slider.hidden = YES;
    slider.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSeckillSliderH);
    slider.delegate = self;
    [self addSubview:slider];
    self.slider = slider;
}

#pragma mark SeckillSliderDelegate

- (void)seckillSlider:(SeckillSlider *)slider didSelectTimeItem:(SeckillTimeTime *)time {
    if ([self.delegate respondsToSelector:@selector(seckillView:actionType:value:)]) {
        [self.delegate seckillView:self actionType:SeckillViewActionTypeSeckillTime value:time];
    }
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    SeckillToolBar *tooBar = [[NSBundle mainBundle] loadNibNamed:@"SeckillToolBar" owner:self options:nil].firstObject;
    tooBar.hidden = YES;
    tooBar.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-kSeckillToolBarH, SCREEN_WIDTH, kSeckillToolBarH);
    tooBar.delegate = self;
    [self addSubview:tooBar];
    self.tooBar = tooBar;
}

#pragma mark SeckillToolBarDelegate

- (void)seckillToolBar:(SeckillToolBar *)toolBar actionType:(SeckillTimeToolBarItemActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(seckillView:actionType:value:)]) {
        [self.delegate seckillView:self actionType:(SeckillViewActionType)type value:value];
    }
}

@end
