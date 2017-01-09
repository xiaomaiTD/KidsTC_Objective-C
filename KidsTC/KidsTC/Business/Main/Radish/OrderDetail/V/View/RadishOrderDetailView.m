//
//  RadishOrderDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailView.h"

#import "NSString+Category.h"
#import "Colours.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "RadishOrderDetailHeader.h"

#import "RadishOrderDetailBaseCell.h"
#import "RadishOrderDetailOrderNoCell.h"
#import "RadishOrderDetailDeliverCell.h"
#import "RadishOrderDetailAddressCell.h"
#import "RadishOrderDetailBookingFailureCell.h"
#import "RadishOrderDetailBookingCell.h"
#import "RadishOrderDetailStoreCell.h"
#import "RadishOrderDetailProductCell.h"
#import "RadishOrderDetailContactCell.h"
#import "RadishOrderDetailUserRemarkCell.h"
#import "RadishOrderDetailPayInfoTitleCell.h"
#import "RadishOrderDetailPayInfoEmptyCell.h"
#import "RadishOrderDetailPayInfoCell.h"
#import "RadishOrderDetailPayInfoTotalCell.h"
#import "RadishOrderDetailRemarkCell.h"
#import "RadishOrderDetailOrderInfoCell.h"
#import "RadishOrderDetailRefundTitleCell.h"
#import "RadishOrderDetailRefundCell.h"
#import "RadishOrderDetailPayTipCell.h"

#import "RadishOrderDetailToolBar.h"

static NSString *const BaseCellID = @"RadishOrderDetailBaseCell";
static NSString *const OrderNoCellID = @"RadishOrderDetailOrderNoCell";
static NSString *const DeliverCellID = @"RadishOrderDetailDeliverCell";
static NSString *const AddressCellID = @"RadishOrderDetailAddressCell";
static NSString *const BookingFailureCellID = @"RadishOrderDetailBookingFailureCell";
static NSString *const BookingCellID = @"RadishOrderDetailBookingCell";
static NSString *const StoreCellID = @"RadishOrderDetailStoreCell";
static NSString *const ProductCellID = @"RadishOrderDetailProductCell";
static NSString *const ContactCellID = @"RadishOrderDetailContactCell";
static NSString *const UserRemarkCellID = @"RadishOrderDetailUserRemarkCell";
static NSString *const PayInfoTitleCellID = @"RadishOrderDetailPayInfoTitleCell";
static NSString *const PayInfoEmptyCellID = @"RadishOrderDetailPayInfoEmptyCell";
static NSString *const PayInfoCellID = @"RadishOrderDetailPayInfoCell";
static NSString *const PayInfoTotalCellID = @"RadishOrderDetailPayInfoTotalCell";
static NSString *const RemarkCellID = @"RadishOrderDetailRemarkCell";
static NSString *const OrderInfoCellID = @"RadishOrderDetailOrderInfoCell";
static NSString *const RefundTitleCellID = @"RadishOrderDetailRefundTitleCell";
static NSString *const RefundCellID = @"RadishOrderDetailRefundCell";
static NSString *const PayTipCellID = @"RadishOrderDetailPayTipCell";

@interface RadishOrderDetailView ()<UITableViewDelegate,UITableViewDataSource,RadishOrderDetailBaseCellDelegate,RadishOrderDetailToolBarDelegate,RadishOrderDetailHeaderDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<RadishOrderDetailBaseCell *> *> *sections;
@property (nonatomic, strong) RadishOrderDetailToolBar *toolBar;
@end

@implementation RadishOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, kRadishOrderDetailToolBarH, 0);
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [self addSubview:tableView];
    self.tableView = tableView;
    [self registerCells];
    
    RadishOrderDetailHeader *header = [self viewWithNib:@"RadishOrderDetailHeader"];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    header.hidden = YES;
    header.delegate = self;
    tableView.tableHeaderView = header;
}

- (void)setData:(RadishOrderDetailData *)data {
    _data = data;
    self.tableView.tableHeaderView.hidden = data == nil;
    self.toolBar.data = data;
    [self setupSections];
    [self.tableView reloadData];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)registerCells {
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailBaseCell"] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailOrderNoCell"] forCellReuseIdentifier:OrderNoCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailDeliverCell"] forCellReuseIdentifier:DeliverCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailAddressCell"] forCellReuseIdentifier:AddressCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailBookingFailureCell"] forCellReuseIdentifier:BookingFailureCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailBookingCell"] forCellReuseIdentifier:BookingCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailStoreCell"] forCellReuseIdentifier:StoreCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailProductCell"] forCellReuseIdentifier:ProductCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailContactCell"] forCellReuseIdentifier:ContactCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailUserRemarkCell"] forCellReuseIdentifier:UserRemarkCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailPayInfoTitleCell"] forCellReuseIdentifier:PayInfoTitleCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailPayInfoEmptyCell"] forCellReuseIdentifier:PayInfoEmptyCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailPayInfoCell"] forCellReuseIdentifier:PayInfoCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailPayInfoTotalCell"] forCellReuseIdentifier:PayInfoTotalCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailRemarkCell"] forCellReuseIdentifier:RemarkCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailOrderInfoCell"] forCellReuseIdentifier:OrderInfoCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailRefundTitleCell"] forCellReuseIdentifier:RefundTitleCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailRefundCell"] forCellReuseIdentifier:RefundCellID];
    [self.tableView registerNib:[self nibWithName:@"RadishOrderDetailPayTipCell"] forCellReuseIdentifier:PayTipCellID];
}

- (void)setupSections{
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section00 = [NSMutableArray array];
    RadishOrderDetailOrderNoCell *orderNoCell = [self cellWithID:OrderNoCellID];
    if (orderNoCell) [section00 addObject:orderNoCell];
    if (section00.count>0) [sections addObject:section00];
    
    NSMutableArray *section01 = [NSMutableArray array];
    if (self.data.deliver) {
        RadishOrderDetailDeliverCell *deliverCell = [self cellWithID:DeliverCellID];
        if (deliverCell) [section01 addObject:deliverCell];
    }
    if (section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    if (self.data.userAddress) {
        RadishOrderDetailAddressCell *addressCell = [self cellWithID:AddressCellID];
        if (addressCell) [section02 addObject:addressCell];
    }
    if (section02.count>0) [sections addObject:section02];
    
    NSMutableArray *section03 = [NSMutableArray array];
    if (self.data.storeInfo && (self.data.placeType != PlaceTypeNone)) {
        RadishOrderDetailStoreCell *storeCell = [self cellWithID:StoreCellID];
        if (storeCell) [section03 addObject:storeCell];
    }
    RadishOrderDetailProductCell *productCell = [self cellWithID:ProductCellID];
    if (productCell) [section03 addObject:productCell];
    if (self.data.supplierPhones.count>0) {
        RadishOrderDetailContactCell *concactCell = [self cellWithID:ContactCellID];
        if (concactCell) [section03 addObject:concactCell];
    }
    if (section03.count>0) [sections addObject:section03];
    
    //在线预约信息
    NSMutableArray *sectionForBooking = [NSMutableArray array];
    if (self.data.onlineBespeakStatus == OrderBookingBespeakStatusBespeakFail) {
        RadishOrderDetailBookingFailureCell *bookingFailureCell = [self cellWithID:BookingFailureCellID];
        if(bookingFailureCell) [sectionForBooking addObject:bookingFailureCell];
    }
    if (self.data.canShowButton) {
        RadishOrderDetailBookingCell *bookingCell = [self cellWithID:BookingCellID];
        if (bookingCell) [sectionForBooking addObject:bookingCell];
    }
    if (sectionForBooking.count>0) [sections addObject:sectionForBooking];
    
    NSMutableArray *sectionForUserRemark = [NSMutableArray array];
    if (self.data.userRemarkStr.length>0) {
        RadishOrderDetailUserRemarkCell *userRemarkCell = [self cellWithID:UserRemarkCellID];
        if (userRemarkCell) [sectionForUserRemark addObject:userRemarkCell];
    }
    if (sectionForUserRemark.count>0) [sections addObject:sectionForUserRemark];
    
    NSMutableArray *section04 = [NSMutableArray array];
    RadishOrderDetailPayInfoTitleCell *payInfoTitleCell = [self cellWithID:PayInfoTitleCellID];
    if (payInfoTitleCell) [section04 addObject:payInfoTitleCell];
    
    RadishOrderDetailPayInfoEmptyCell *payInfoEmptyCell_price = [self cellWithID:PayInfoEmptyCellID];
    if (payInfoEmptyCell_price) [section04 addObject:payInfoEmptyCell_price];
    RadishOrderDetailPayInfoCell *payInfoCell_price = [self cellWithID:PayInfoCellID];
    payInfoCell_price.type = RadishOrderDetailPayInfoCellTypeTypePrice;
    if (payInfoCell_price) [section04 addObject:payInfoCell_price];
    
    RadishOrderDetailPayInfoEmptyCell *payInfoEmptyCell_promotion = [self cellWithID:PayInfoEmptyCellID];
    if (payInfoEmptyCell_promotion) [section04 addObject:payInfoEmptyCell_promotion];
    RadishOrderDetailPayInfoCell *payInfoCell_promotion = [self cellWithID:PayInfoCellID];
    payInfoCell_promotion.type = RadishOrderDetailPayInfoCellTypeTypePromotion;
    if (payInfoCell_promotion) [section04 addObject:payInfoCell_promotion];
    
    RadishOrderDetailPayInfoEmptyCell *payInfoEmptyCell_score = [self cellWithID:PayInfoEmptyCellID];
    if (payInfoEmptyCell_score) [section04 addObject:payInfoEmptyCell_score];
    RadishOrderDetailPayInfoCell *payInfoCell_score = [self cellWithID:PayInfoCellID];
    payInfoCell_score.type = RadishOrderDetailPayInfoCellTypeTypeScore;
    if (payInfoCell_score) [section04 addObject:payInfoCell_score];
    
    if (self.data.transportationExpenses>0) {
        RadishOrderDetailPayInfoEmptyCell *payInfoEmptyCell_transportationExpenses = [self cellWithID:PayInfoEmptyCellID];
        if (payInfoEmptyCell_transportationExpenses) [section04 addObject:payInfoEmptyCell_transportationExpenses];
        RadishOrderDetailPayInfoCell *payInfoCell_transportationExpenses = [self cellWithID:PayInfoCellID];
        payInfoCell_transportationExpenses.type = RadishOrderDetailPayInfoCellTypeTransportationExpenses;
        if (payInfoCell_transportationExpenses) [section04 addObject:payInfoCell_transportationExpenses];
    }
    
    RadishOrderDetailPayInfoEmptyCell *payInfoEmptyCell_last = [self cellWithID:PayInfoEmptyCellID];
    if (payInfoEmptyCell_last) [section04 addObject:payInfoEmptyCell_last];
    
    RadishOrderDetailPayInfoTotalCell *payInfoTotalCell = [self cellWithID:PayInfoTotalCellID];
    if(payInfoTotalCell) [section04 addObject:payInfoTotalCell];
    
    if (section04.count>0) [sections addObject:section04];
    
    NSMutableArray *section05 = [NSMutableArray array];
    if (self.data.remarks.count>0) {
        RadishOrderDetailRemarkCell *remarkCell = [self cellWithID:RemarkCellID];
        if (remarkCell) [section05 addObject:remarkCell];
    }
    if (section05.count>0) [sections addObject:section05];
    
    /*
    NSMutableArray *section06 = [NSMutableArray array];
    RadishOrderDetailOrderInfoCell *orderInfoCell = [self cellWithID:OrderInfoCellID];
    if (orderInfoCell) [section06 addObject:orderInfoCell];
    if (section06.count>0) [sections addObject:section06];
     */
    
    NSMutableArray *section07 = [NSMutableArray array];
    if (self.data.refunds.count>0) {
        RadishOrderDetailRefundTitleCell *refundTitleCell = [self cellWithID:RefundTitleCellID];
        if(refundTitleCell) [section07 addObject:refundTitleCell];
        [self.data.refunds enumerateObjectsUsingBlock:^(RadishOrderDetailRefund *obj, NSUInteger idx, BOOL *stop) {
            RadishOrderDetailRefundCell *refundCell = [self cellWithID:RefundCellID];
            refundCell.tag = idx;
            if (refundCell) [section07 addObject:refundCell];
        }];
    }
    if (section07.count>0) [sections addObject:section07];
    
    /*
    NSMutableArray *section08 = [NSMutableArray array];
    if ([self.data.expireTimeDesc isNotNull]) {
        RadishOrderDetailPayTipCell *payTipCell = [self cellWithID:PayTipCellID];
        if (payTipCell) [section08 addObject:payTipCell];
    }
    if (section08.count>0) [sections addObject:section08];
    */
    
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
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section==self.sections.count-1)?0.001:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<RadishOrderDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            RadishOrderDetailBaseCell *cell = rows[row];
            cell.data = self.data;
            cell.delegate = self;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark - RadishOrderDetailBaseCellDelegate

- (void)radishOrderDetailBaseCell:(RadishOrderDetailBaseCell *)cell actionType:(RadishOrderDetailBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishOrderDetailView:actionType:value:)]) {
        [self.delegate radishOrderDetailView:self actionType:(RadishOrderDetailViewActionType)type value:value];
    }
}

- (void)setupToolBar {
    RadishOrderDetailToolBar *toolBar = [self viewWithNib:@"RadishOrderDetailToolBar"];
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT - kRadishOrderDetailToolBarH, SCREEN_WIDTH, kRadishOrderDetailToolBarH);
    toolBar.delegate = self;
    toolBar.hidden = YES;
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma marl - RadishOrderDetailToolBarDelegate

- (void)radishOrderDetailToolBar:(RadishOrderDetailToolBar *)toolBar actionType:(RadishOrderDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishOrderDetailView:actionType:value:)]) {
        [self.delegate radishOrderDetailView:self actionType:(RadishOrderDetailViewActionType)type value:value];
    }
}

#pragma mark - RadishOrderDetailHeaderDelegate

- (void)radishOrderDetailHeader:(RadishOrderDetailHeader *)header actionType:(RadishOrderDetailHeaderActionType)type {
    switch (type) {
        case RadishOrderDetailHeaderActionTypeClose:
        {
            self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.001)];
        }
            break;
        case RadishOrderDetailHeaderActionTypeShowRule:
        {
            if ([self.delegate respondsToSelector:@selector(radishOrderDetailView:actionType:value:)]) {
                [self.delegate radishOrderDetailView:self actionType:RadishOrderDetailViewActionTypeShowRule value:self.data];
            }
        }
            break;
        default:
            break;
    }
}


#pragma mark - helpers

- (nullable __kindof UITableViewCell *)cellWithID:(NSString *)ID {
    return [self.tableView dequeueReusableCellWithIdentifier:ID];
}

- (id)viewWithNib:(NSString *)nib {
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (UINib *)nibWithName:(NSString *)name {
    return [UINib nibWithNibName:name bundle:nil];
}

@end
