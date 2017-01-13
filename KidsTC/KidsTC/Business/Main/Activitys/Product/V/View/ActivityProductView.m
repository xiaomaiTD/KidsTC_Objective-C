//
//  ActivityProductView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductView.h"


#import "ActivityProductSlider.h"
#import "ActivityProductToolBar.h"

#import "ActivityProductBaseCell.h"
#import "ActivityProductBannerCell.h"
#import "ActivityProductCountDownCell.h"
#import "ActivityProductCollectionCell.h"

static NSString *const BaseCellID = @"ActivityProductBaseCell";
static NSString *const BannerCellID = @"ActivityProductBannerCell";
static NSString *const CountDownCellID = @"ActivityProductCountDownCell";
static NSString *const CollectionCellID = @"ActivityProductCollectionCell";

@interface ActivityProductView ()<UITableViewDelegate,UITableViewDataSource,ActivityProductSliderDelegate,ActivityProductToolBarDelegate>
@property (nonatomic, strong) ActivityProductSlider *slider;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ActivityProductToolBar *tooBar;
@end

@implementation ActivityProductView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSlider];
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(ActivityProductData *)data {
    _data = data;
    self.slider.content = data.sliderContent;
    self.tooBar.content = data.toolBarContent;
    [self.tableView reloadData];
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kActivityProductSliderH, SCREEN_WIDTH, CGRectGetHeight(self.bounds)-kActivityProductSliderH-kActivityProductToolBarH) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 120;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    [self registerCells];
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityProductBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityProductBannerCell" bundle:nil] forCellReuseIdentifier:BannerCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityProductCountDownCell" bundle:nil] forCellReuseIdentifier:CountDownCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityProductCollectionCell" bundle:nil] forCellReuseIdentifier:CollectionCellID];
}

- (NSString *)cellIdWithType:(ActivityProductContentType)type {
    switch (type) {
        case ActivityProductContentTypeBanner:
        {
            return BannerCellID;
        }
            break;
        case ActivityProductContentTypeCountDown:
        {
            return CountDownCellID;
        }
            break;
        case ActivityProductContentTypeMedium:
        case ActivityProductContentTypeLarge:
        case ActivityProductContentTypeSmall:
        case ActivityProductContentTypeCoupon:
        {
            return CollectionCellID;
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
    return self.data.showFloorItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    NSArray<ActivityProductFloorItem *> *showFloorItems = self.data.showFloorItems;
    if (row<showFloorItems.count) {
        ActivityProductFloorItem *floorItem = showFloorItems[row];
        NSString *cellId = [self cellIdWithType:floorItem.contentType];
        ActivityProductBaseCell *cell = [self cellWithID:cellId];
        cell.floorItem = floorItem;
        if (cell) return cell;
    }
    return [self cellWithID:BaseCellID];
}

#pragma mark - setupSlider

- (void)setupSlider {
    ActivityProductSlider *slider = [[NSBundle mainBundle] loadNibNamed:@"ActivityProductSlider" owner:self options:nil].firstObject;
    //slider.hidden = YES;
    slider.frame = CGRectMake(0, 0, SCREEN_WIDTH, kActivityProductSliderH);
    slider.delegate = self;
    [self addSubview:slider];
    self.slider = slider;
}

#pragma mark ActivityProductSliderDelegate

- (void)activityProductSlider:(ActivityProductSlider *)slider didSelectItem:(ActivityProductTabItem *)item index:(NSInteger)index{
    
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    ActivityProductToolBar *tooBar = [[NSBundle mainBundle] loadNibNamed:@"ActivityProductToolBar" owner:self options:nil].firstObject;
    //tooBar.hidden = YES;
    tooBar.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-kActivityProductToolBarH, SCREEN_WIDTH, kActivityProductToolBarH);
    tooBar.delegate = self;
    [self addSubview:tooBar];
    self.tooBar = tooBar;
}

#pragma mark ActivityProductToolBarDelegate

- (void)activityProductToolBar:(ActivityProductToolBar *)toolBar didSelectItem:(ActivityProductTabItem *)item index:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(activityProductView:actionType:value:)]) {
        [self.delegate activityProductView:self actionType:ActivityProductViewActionTypeSegue value:item.segueModel];
    }
}

@end
