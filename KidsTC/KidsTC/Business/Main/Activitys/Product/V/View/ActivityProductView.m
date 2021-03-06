//
//  ActivityProductView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductView.h"

#import "BuryPointManager.h"

#import "ActivityProductSlider.h"
#import "ActivityProductToolBar.h"

#import "ActivityProductBaseCell.h"
#import "ActivityProductBannerCell.h"
#import "ActivityProductCountDownCell.h"
#import "ActivityProductProductsCell.h"
#import "ActivityProductCouponsCell.h"
#import "NSString+Category.h"

static NSString *const BaseCellID = @"ActivityProductBaseCell";
static NSString *const BannerCellID = @"ActivityProductBannerCell";
static NSString *const CountDownCellID = @"ActivityProductCountDownCell";
static NSString *const ProductsCellID = @"ActivityProductProductsCell";
static NSString *const CouponsCellID = @"ActivityProductCouponsCell";

@interface ActivityProductView ()<UITableViewDelegate,UITableViewDataSource,ActivityProductBaseCellDelegate,ActivityProductSliderDelegate,ActivityProductToolBarDelegate>
@property (nonatomic, strong) ActivityProductSlider *slider;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ActivityProductToolBar *tooBar;
@property (nonatomic, assign) BOOL didClickToolBar;
@end

@implementation ActivityProductView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSlider];
        [self setupToolBar];
        [self setupTableView];
    }
    return self;
}

- (void)setData:(ActivityProductData *)data {
    _data = data;
    
    [self setupColor];
    
    [self setupFrame];

    self.slider.content = data.sliderContent;
    self.tooBar.content = data.toolBarContent;
    
    [self.tableView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidScroll:self.tableView];
    });
}

- (void)setupColor {
    NSString *bgColor = self.data.eventBaseInfo.bgColor;
    UIColor *color = [UIColor colorFromHexString:bgColor];
    self.tableView.backgroundColor = color;
    self.backgroundColor = color;
}

- (void)setupFrame {
    
    CGFloat self_h = CGRectGetHeight(self.bounds);
    CGFloat self_w = CGRectGetWidth(self.bounds);
    
    CGFloat tableView_x = 0;
    CGFloat tableView_y = 0;
    CGFloat tableView_h = self_h;
    CGFloat tableView_w = self_w;
    
    
    CGFloat slider_x = 0;
    CGFloat slider_y = 0;
    CGFloat slider_w = self_w;
    CGFloat slider_h = 0;
    
    ActivityProductContent *sliderContent = self.data.sliderContent;
    NSArray<ActivityProductTabItem *> *sliderTabItems = sliderContent.tabItems;
    if (sliderTabItems.count>0) {
        slider_h = kActivityProductSliderH;
        tableView_y = slider_h;
        tableView_h -= slider_h;
    }
    
    CGFloat toolBar_x = 0;
    CGFloat toolBar_h = 0;
    CGFloat toolBar_w = self_w;
    CGFloat toolBar_y = 0;
    
    ActivityProductContent *toolBarContent = self.data.toolBarContent;
    NSArray<ActivityProductTabItem *> *toolBarTabItems = toolBarContent.tabItems;
    if (toolBarTabItems.count>0) {
        ActivityProductTabItem *tabItem = toolBarTabItems.firstObject;
        toolBar_h = tabItem.tabHeight;
        toolBar_y = self_h - toolBar_h;
        tableView_h -= toolBar_h;
    }
    
    self.tableView.frame = CGRectMake(tableView_x, tableView_y, tableView_w, tableView_h);
    self.slider.frame = CGRectMake(slider_x, slider_y, slider_w, slider_h);
    self.tooBar.frame = CGRectMake(toolBar_x, toolBar_y, toolBar_w, toolBar_h);
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
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityProductProductsCell" bundle:nil] forCellReuseIdentifier:ProductsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityProductCouponsCell" bundle:nil] forCellReuseIdentifier:CouponsCellID];
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
        {
            return ProductsCellID;
        }
            break;
        case ActivityProductContentTypeCoupon:
        {
            return CouponsCellID;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.didClickToolBar) {
        NSArray<NSIndexPath *> *indexPathsForVisibleRows = [self.tableView indexPathsForVisibleRows];
        if (indexPathsForVisibleRows.count>0) {
            NSIndexPath *indexPath = indexPathsForVisibleRows.firstObject;
            NSUInteger section = indexPath.section;
            NSArray<ActivityProductFloorItem *> *showFloorItems = self.data.showFloorItems;
            if (section<showFloorItems.count) {
                ActivityProductFloorItem *floorItem = showFloorItems[section];
                [self.slider selectIndex:floorItem.sliderTabItemIndex toSelect:floorItem.hasSliderTabItem];
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.showFloorItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSArray<ActivityProductFloorItem *> *showFloorItems = self.data.showFloorItems;
    if (section<showFloorItems.count) {
        ActivityProductFloorItem *floorItem = showFloorItems[section];
        return floorItem.marginTop;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    NSArray<ActivityProductFloorItem *> *showFloorItems = self.data.showFloorItems;
    if (section<showFloorItems.count) {
        ActivityProductFloorItem *floorItem = showFloorItems[section];
        NSString *cellId = [self cellIdWithType:floorItem.contentType];
        ActivityProductBaseCell *cell = [self cellWithID:cellId];
        cell.floorItem = floorItem;
        cell.delegate = self;
        //[self.slider selectIndex:floorItem.sliderTabItemIndex toSelect:floorItem.hasSliderTabItem];
        if (cell) return cell;
    }
    return [self cellWithID:BaseCellID];
}

#pragma mark - ActivityProductBaseCellDelegate

- (void)activityProductBaseCell:(ActivityProductBaseCell *)cell actionType:(ActivityProductBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(activityProductView:actionType:value:)]) {
        [self.delegate activityProductView:self actionType:(ActivityProductViewActionType)type value:value];
    }
}

#pragma mark - setupSlider

- (void)setupSlider {
    ActivityProductSlider *slider = [[NSBundle mainBundle] loadNibNamed:@"ActivityProductSlider" owner:self options:nil].firstObject;
    slider.hidden = YES;
    slider.frame = CGRectMake(0, 0, SCREEN_WIDTH, kActivityProductSliderH);
    slider.delegate = self;
    [self addSubview:slider];
    self.slider = slider;
}

#pragma mark ActivityProductSliderDelegate

- (void)activityProductSlider:(ActivityProductSlider *)slider didSelectItem:(ActivityProductTabItem *)item index:(NSInteger)index{
    [self.slider selectIndex:index toSelect:YES];
    self.didClickToolBar = YES;
    NSUInteger sectioinIndex = item.sectioinIndex;
    if (sectioinIndex<self.data.showFloorItems.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sectioinIndex];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.didClickToolBar = NO;
    });
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *fid = [NSString stringWithFormat:@"%@",item.params[@"fid"]];
    if ([fid isNotNull]) {
        [params setObject:fid forKey:@"fid"];
    }
    NSString *ID = self.data.eventBaseInfo.eventSysNoEn;
    if ([ID isNotNull]) {
        [params setObject:ID forKey:@"id"];
    }
    [BuryPointManager trackEvent:@"event_click_activity_change_loc" actionId:22002 params:params];
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    ActivityProductToolBar *tooBar = [[NSBundle mainBundle] loadNibNamed:@"ActivityProductToolBar" owner:self options:nil].firstObject;
    tooBar.hidden = YES;
    tooBar.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-kActivityProductToolBarH, SCREEN_WIDTH, kActivityProductToolBarH);
    tooBar.delegate = self;
    [self addSubview:tooBar];
    self.tooBar = tooBar;
}

#pragma mark ActivityProductToolBarDelegate

- (void)activityProductToolBar:(ActivityProductToolBar *)toolBar actionType:(ActivityProductToolBarActionType)type value:(id)value{
    if ([self.delegate respondsToSelector:@selector(activityProductView:actionType:value:)]) {
        [self.delegate activityProductView:self actionType:ActivityProductViewActionTypeSegue value:value];
    }
}

@end
