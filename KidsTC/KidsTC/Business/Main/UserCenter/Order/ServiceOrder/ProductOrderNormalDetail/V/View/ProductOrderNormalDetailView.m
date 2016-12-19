//
//  ProductOrderNormalDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailView.h"

#import "NSString+Category.h"
#import "Colours.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "ProductOrderNormalDetailHeader.h"

#import "ProductOrderNormalDetailBaseCell.h"
#import "ProductOrderNormalDetailOrderNoCell.h"
#import "ProductOrderNormalDetailDeliverCell.h"
#import "ProductOrderNormalDetailAddressCell.h"
#import "ProductOrderNormalDetailBookingFailureCell.h"
#import "ProductOrderNormalDetailBookingCell.h"
#import "ProductOrderNormalDetailStoreCell.h"
#import "ProductOrderNormalDetailProductCell.h"
#import "ProductOrderNormalDetailContactCell.h"
#import "ProductOrderNormalDetailUserRemarkCell.h"
#import "ProductOrderNormalDetailPayInfoTitleCell.h"
#import "ProductOrderNormalDetailPayInfoEmptyCell.h"
#import "ProductOrderNormalDetailPayInfoCell.h"
#import "ProductOrderNormalDetailPayInfoTotalCell.h"
#import "ProductOrderNormalDetailRemarkCell.h"
#import "ProductOrderNormalDetailOrderInfoCell.h"
#import "ProductOrderNormalDetailRefundTitleCell.h"
#import "ProductOrderNormalDetailRefundCell.h"
#import "ProductOrderNormalDetailPayTipCell.h"

#import "ProductOrderNormalDetailToolBar.h"

static NSString *const BaseCellID = @"ProductOrderNormalDetailBaseCell";
static NSString *const OrderNoCellID = @"ProductOrderNormalDetailOrderNoCell";
static NSString *const DeliverCellID = @"ProductOrderNormalDetailDeliverCell";
static NSString *const AddressCellID = @"ProductOrderNormalDetailAddressCell";
static NSString *const BookingFailureCellID = @"ProductOrderNormalDetailBookingFailureCell";
static NSString *const BookingCellID = @"ProductOrderNormalDetailBookingCell";
static NSString *const StoreCellID = @"ProductOrderNormalDetailStoreCell";
static NSString *const ProductCellID = @"ProductOrderNormalDetailProductCell";
static NSString *const ContactCellID = @"ProductOrderNormalDetailContactCell";
static NSString *const UserRemarkCellID = @"ProductOrderNormalDetailUserRemarkCell";
static NSString *const PayInfoTitleCellID = @"ProductOrderNormalDetailPayInfoTitleCell";
static NSString *const PayInfoEmptyCellID = @"ProductOrderNormalDetailPayInfoEmptyCell";
static NSString *const PayInfoCellID = @"ProductOrderNormalDetailPayInfoCell";
static NSString *const PayInfoTotalCellID = @"ProductOrderNormalDetailPayInfoTotalCell";
static NSString *const RemarkCellID = @"ProductOrderNormalDetailRemarkCell";
static NSString *const OrderInfoCellID = @"ProductOrderNormalDetailOrderInfoCell";
static NSString *const RefundTitleCellID = @"ProductOrderNormalDetailRefundTitleCell";
static NSString *const RefundCellID = @"ProductOrderNormalDetailRefundCell";
static NSString *const PayTipCellID = @"ProductOrderNormalDetailPayTipCell";

@interface ProductOrderNormalDetailView ()<UITableViewDelegate,UITableViewDataSource,ProductOrderNormalDetailBaseCellDelegate,ProductOrderNormalDetailToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<ProductOrderNormalDetailBaseCell *> *> *sections;
@property (nonatomic, strong) ProductOrderNormalDetailToolBar *toolBar;
@end

@implementation ProductOrderNormalDetailView

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
    tableView.contentInset = UIEdgeInsetsMake(0, 0, kProductOrderNormalDetailToolBarH, 0);
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [self addSubview:tableView];
    self.tableView = tableView;
    [self registerCells];
    
    ProductOrderNormalDetailHeader *header = [self viewWithNib:@"ProductOrderNormalDetailHeader"];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    header.hidden = YES;
    header.actionBlock = ^(){
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.001)];
    };
    tableView.tableHeaderView = header;
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    _data = data;
    if (data) {
        self.tableView.tableHeaderView.hidden = NO;
    }
    self.toolBar.data = data;
    [self setupSections];
    [self.tableView reloadData];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)registerCells {
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailBaseCell"] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailOrderNoCell"] forCellReuseIdentifier:OrderNoCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailDeliverCell"] forCellReuseIdentifier:DeliverCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailAddressCell"] forCellReuseIdentifier:AddressCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailBookingFailureCell"] forCellReuseIdentifier:BookingFailureCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailBookingCell"] forCellReuseIdentifier:BookingCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailStoreCell"] forCellReuseIdentifier:StoreCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailProductCell"] forCellReuseIdentifier:ProductCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailContactCell"] forCellReuseIdentifier:ContactCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailUserRemarkCell"] forCellReuseIdentifier:UserRemarkCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailPayInfoTitleCell"] forCellReuseIdentifier:PayInfoTitleCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailPayInfoEmptyCell"] forCellReuseIdentifier:PayInfoEmptyCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailPayInfoCell"] forCellReuseIdentifier:PayInfoCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailPayInfoTotalCell"] forCellReuseIdentifier:PayInfoTotalCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailRemarkCell"] forCellReuseIdentifier:RemarkCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailOrderInfoCell"] forCellReuseIdentifier:OrderInfoCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailRefundTitleCell"] forCellReuseIdentifier:RefundTitleCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailRefundCell"] forCellReuseIdentifier:RefundCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderNormalDetailPayTipCell"] forCellReuseIdentifier:PayTipCellID];
}

- (void)setupSections{
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section00 = [NSMutableArray array];
    ProductOrderNormalDetailOrderNoCell *orderNoCell = [self cellWithID:OrderNoCellID];
    if (orderNoCell) [section00 addObject:orderNoCell];
    if (section00.count>0) [sections addObject:section00];
    
    NSMutableArray *section01 = [NSMutableArray array];
    if (self.data.deliver) {
        ProductOrderNormalDetailDeliverCell *deliverCell = [self cellWithID:DeliverCellID];
        if (deliverCell) [section01 addObject:deliverCell];
    }
    if (section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    if (self.data.userAddress) {
        ProductOrderNormalDetailAddressCell *addressCell = [self cellWithID:AddressCellID];
        if (addressCell) [section02 addObject:addressCell];
    }
    if (section02.count>0) [sections addObject:section02];
    
    NSMutableArray *section03 = [NSMutableArray array];
    if (self.data.storeInfo && (self.data.placeType != PlaceTypeNone)) {
        ProductOrderNormalDetailStoreCell *storeCell = [self cellWithID:StoreCellID];
        if (storeCell) [section03 addObject:storeCell];
    }
    ProductOrderNormalDetailProductCell *productCell = [self cellWithID:ProductCellID];
    if (productCell) [section03 addObject:productCell];
    if (self.data.supplierPhones.count>0) {
        ProductOrderNormalDetailContactCell *concactCell = [self cellWithID:ContactCellID];
        if (concactCell) [section03 addObject:concactCell];
    }
    if (section03.count>0) [sections addObject:section03];
    
    //在线预约信息
    NSMutableArray *sectionForBooking = [NSMutableArray array];
    if (self.data.onlineBespeakStatus == OrderBookingBespeakStatusBespeakFail) {
        ProductOrderNormalDetailBookingFailureCell *bookingFailureCell = [self cellWithID:BookingFailureCellID];
        if(bookingFailureCell) [sectionForBooking addObject:bookingFailureCell];
    }
    if (self.data.canShowButton) {
        ProductOrderNormalDetailBookingCell *bookingCell = [self cellWithID:BookingCellID];
        if (bookingCell) [sectionForBooking addObject:bookingCell];
    }
    if (sectionForBooking.count>0) [sections addObject:sectionForBooking];
    
    NSMutableArray *sectionForUserRemark = [NSMutableArray array];
    if (self.data.userRemarkStr.length>0) {
        ProductOrderNormalDetailUserRemarkCell *userRemarkCell = [self cellWithID:UserRemarkCellID];
        if (userRemarkCell) [sectionForUserRemark addObject:userRemarkCell];
    }
    if (sectionForUserRemark.count>0) [sections addObject:sectionForUserRemark];
    
    NSMutableArray *section04 = [NSMutableArray array];
    ProductOrderNormalDetailPayInfoTitleCell *payInfoTitleCell = [self cellWithID:PayInfoTitleCellID];
    if (payInfoTitleCell) [section04 addObject:payInfoTitleCell];
    
    ProductOrderNormalDetailPayInfoEmptyCell *payInfoEmptyCell_price = [self cellWithID:PayInfoEmptyCellID];
    if (payInfoEmptyCell_price) [section04 addObject:payInfoEmptyCell_price];
    ProductOrderNormalDetailPayInfoCell *payInfoCell_price = [self cellWithID:PayInfoCellID];
    payInfoCell_price.type = ProductOrderNormalDetailPayInfoCellTypeTypePrice;
    if (payInfoCell_price) [section04 addObject:payInfoCell_price];
    
    ProductOrderNormalDetailPayInfoEmptyCell *payInfoEmptyCell_promotion = [self cellWithID:PayInfoEmptyCellID];
    if (payInfoEmptyCell_promotion) [section04 addObject:payInfoEmptyCell_promotion];
    ProductOrderNormalDetailPayInfoCell *payInfoCell_promotion = [self cellWithID:PayInfoCellID];
    payInfoCell_promotion.type = ProductOrderNormalDetailPayInfoCellTypeTypePromotion;
    if (payInfoCell_promotion) [section04 addObject:payInfoCell_promotion];
    
    ProductOrderNormalDetailPayInfoEmptyCell *payInfoEmptyCell_score = [self cellWithID:PayInfoEmptyCellID];
    if (payInfoEmptyCell_score) [section04 addObject:payInfoEmptyCell_score];
    ProductOrderNormalDetailPayInfoCell *payInfoCell_score = [self cellWithID:PayInfoCellID];
    payInfoCell_score.type = ProductOrderNormalDetailPayInfoCellTypeTypeScore;
    if (payInfoCell_score) [section04 addObject:payInfoCell_score];
    
    if (self.data.transportationExpenses>0) {
        ProductOrderNormalDetailPayInfoEmptyCell *payInfoEmptyCell_transportationExpenses = [self cellWithID:PayInfoEmptyCellID];
        if (payInfoEmptyCell_transportationExpenses) [section04 addObject:payInfoEmptyCell_transportationExpenses];
        ProductOrderNormalDetailPayInfoCell *payInfoCell_transportationExpenses = [self cellWithID:PayInfoCellID];
        payInfoCell_transportationExpenses.type = ProductOrderNormalDetailPayInfoCellTypeTransportationExpenses;
        if (payInfoCell_transportationExpenses) [section04 addObject:payInfoCell_transportationExpenses];
    }
    
    ProductOrderNormalDetailPayInfoEmptyCell *payInfoEmptyCell_last = [self cellWithID:PayInfoEmptyCellID];
    if (payInfoEmptyCell_last) [section04 addObject:payInfoEmptyCell_last];
    
    ProductOrderNormalDetailPayInfoTotalCell *payInfoTotalCell = [self cellWithID:PayInfoTotalCellID];
    if(payInfoTotalCell) [section04 addObject:payInfoTotalCell];
    
    if (section04.count>0) [sections addObject:section04];
    
    NSMutableArray *section05 = [NSMutableArray array];
    if (self.data.remarks.count>0) {
        ProductOrderNormalDetailRemarkCell *remarkCell = [self cellWithID:RemarkCellID];
        if (remarkCell) [section05 addObject:remarkCell];
    }
    if (section05.count>0) [sections addObject:section05];
    
    /*
    NSMutableArray *section06 = [NSMutableArray array];
    ProductOrderNormalDetailOrderInfoCell *orderInfoCell = [self cellWithID:OrderInfoCellID];
    if (orderInfoCell) [section06 addObject:orderInfoCell];
    if (section06.count>0) [sections addObject:section06];
     */
    
    NSMutableArray *section07 = [NSMutableArray array];
    if (self.data.refunds.count>0) {
        ProductOrderNormalDetailRefundTitleCell *refundTitleCell = [self cellWithID:RefundTitleCellID];
        if(refundTitleCell) [section07 addObject:refundTitleCell];
        [self.data.refunds enumerateObjectsUsingBlock:^(ProductOrderNormalDetailRefund *obj, NSUInteger idx, BOOL *stop) {
            ProductOrderNormalDetailRefundCell *refundCell = [self cellWithID:RefundCellID];
            refundCell.tag = idx;
            if (refundCell) [section07 addObject:refundCell];
        }];
    }
    if (section07.count>0) [sections addObject:section07];
    
    /*
    NSMutableArray *section08 = [NSMutableArray array];
    if ([self.data.expireTimeDesc isNotNull]) {
        ProductOrderNormalDetailPayTipCell *payTipCell = [self cellWithID:PayTipCellID];
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
        NSArray<ProductOrderNormalDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            ProductOrderNormalDetailBaseCell *cell = rows[row];
            cell.data = self.data;
            cell.delegate = self;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark - ProductOrderNormalDetailBaseCellDelegate

- (void)productOrderNormalDetailBaseCell:(ProductOrderNormalDetailBaseCell *)cell actionType:(ProductOrderNormalDetailBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderNormalDetailView:actionType:value:)]) {
        [self.delegate productOrderNormalDetailView:self actionType:(ProductOrderNormalDetailViewActionType)type value:value];
    }
}

- (void)setupToolBar {
    ProductOrderNormalDetailToolBar *toolBar = [self viewWithNib:@"ProductOrderNormalDetailToolBar"];
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT - kProductOrderNormalDetailToolBarH, SCREEN_WIDTH, kProductOrderNormalDetailToolBarH);
    toolBar.delegate = self;
    toolBar.hidden = YES;
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma marl - ProductOrderNormalDetailToolBarDelegate

- (void)productOrderNormalDetailToolBar:(ProductOrderNormalDetailToolBar *)toolBar actionType:(ProductOrderNormalDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderNormalDetailView:actionType:value:)]) {
        [self.delegate productOrderNormalDetailView:self actionType:(ProductOrderNormalDetailViewActionType)type value:value];
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
