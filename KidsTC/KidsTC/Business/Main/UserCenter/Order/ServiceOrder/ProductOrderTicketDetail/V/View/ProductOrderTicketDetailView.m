//
//  ProductOrderTicketDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailView.h"

#import "NSString+Category.h"
#import "Colours.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "ProductOrderNormalDetailHeader.h"

#import "ProductOrderTicketDetailBaseCell.h"
#import "ProductOrderTicketDetailOrderNoCell.h"
#import "ProductOrderTicketDetailDeliverCell.h"
#import "ProductOrderTicketDetailAddressCell.h"
#import "ProductOrderTicketDetailProductCell.h"
#import "ProductOrderTicketDetailContactCell.h"
#import "ProductOrderTicketDetailUserRemarkCell.h"
#import "ProductOrderTicketDetailPayInfoTitleCell.h"
#import "ProductOrderTicketDetailEmptyCell.h"
#import "ProductOrderTicketDetailPayInfoCell.h"
#import "ProductOrderTicketDetailPayInfoTotalCell.h"
#import "ProductOrderTicketDetailRemarkCell.h"
#import "ProductOrderTicketDetailRefundTitleCell.h"
#import "ProductOrderTicketDetailRefundCell.h"
#import "ProductOrderTicketDetailSeatCell.h"
#import "ProductOrderTicketDetailTimeCell.h"
#import "ProductOrderTicketDetailTheatherAddressCell.h"

#import "ProductOrderTicketDetailToolBar.h"

static NSString *const BaseCellID = @"ProductOrderTicketDetailBaseCell";
static NSString *const OrderNoCellID = @"ProductOrderTicketDetailOrderNoCell";
static NSString *const DeliverCellID = @"ProductOrderTicketDetailDeliverCell";
static NSString *const AddressCellID = @"ProductOrderTicketDetailAddressCell";
static NSString *const StoreCellID = @"ProductOrderTicketDetailStoreCell";
static NSString *const ProductCellID = @"ProductOrderTicketDetailProductCell";
static NSString *const ContactCellID = @"ProductOrderTicketDetailContactCell";
static NSString *const UserRemarkCellID = @"ProductOrderTicketDetailUserRemarkCell";
static NSString *const PayInfoTitleCellID = @"ProductOrderTicketDetailPayInfoTitleCell";
static NSString *const EmptyCellID = @"ProductOrderTicketDetailEmptyCell";
static NSString *const PayInfoCellID = @"ProductOrderTicketDetailPayInfoCell";
static NSString *const PayInfoTotalCellID = @"ProductOrderTicketDetailPayInfoTotalCell";
static NSString *const RemarkCellID = @"ProductOrderTicketDetailRemarkCell";
static NSString *const RefundTitleCellID = @"ProductOrderTicketDetailRefundTitleCell";
static NSString *const RefundCellID = @"ProductOrderTicketDetailRefundCell";
static NSString *const SeatCellID = @"ProductOrderTicketDetailSeatCell";
static NSString *const TimeCellID = @"ProductOrderTicketDetailTimeCell";
static NSString *const TheatherAddressCellID = @"ProductOrderTicketDetailTheatherAddressCell";

@interface ProductOrderTicketDetailView ()<UITableViewDelegate,UITableViewDataSource,ProductOrderTicketDetailBaseCellDelegate,ProductOrderTicketDetailToolBarDelegate,ProductOrderNormalDetailHeaderDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<ProductOrderTicketDetailBaseCell *> *> *sections;
@property (nonatomic, strong) ProductOrderTicketDetailToolBar *toolBar;
@end

@implementation ProductOrderTicketDetailView

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
    tableView.contentInset = UIEdgeInsetsMake(0, 0, kProductOrderTicketDetailToolBarH, 0);
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [self addSubview:tableView];
    self.tableView = tableView;
    [self registerCells];
    
    ProductOrderNormalDetailHeader *header = [self viewWithNib:@"ProductOrderNormalDetailHeader"];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    header.hidden = YES;
    header.delegate = self;
    tableView.tableHeaderView = header;
}

- (void)setData:(ProductOrderTicketDetailData *)data {
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
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailBaseCell"] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailOrderNoCell"] forCellReuseIdentifier:OrderNoCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailDeliverCell"] forCellReuseIdentifier:DeliverCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailAddressCell"] forCellReuseIdentifier:AddressCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailStoreCell"] forCellReuseIdentifier:StoreCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailProductCell"] forCellReuseIdentifier:ProductCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailContactCell"] forCellReuseIdentifier:ContactCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailUserRemarkCell"] forCellReuseIdentifier:UserRemarkCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailPayInfoTitleCell"] forCellReuseIdentifier:PayInfoTitleCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailEmptyCell"] forCellReuseIdentifier:EmptyCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailPayInfoCell"] forCellReuseIdentifier:PayInfoCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailPayInfoTotalCell"] forCellReuseIdentifier:PayInfoTotalCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailRemarkCell"] forCellReuseIdentifier:RemarkCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailRefundTitleCell"] forCellReuseIdentifier:RefundTitleCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailRefundCell"] forCellReuseIdentifier:RefundCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailSeatCell"] forCellReuseIdentifier:SeatCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailTimeCell"] forCellReuseIdentifier:TimeCellID];
    [self.tableView registerNib:[self nibWithName:@"ProductOrderTicketDetailTheatherAddressCell"] forCellReuseIdentifier:TheatherAddressCellID];
}

- (void)setupSections{
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section00 = [NSMutableArray array];
    ProductOrderTicketDetailOrderNoCell *orderNoCell = [self cellWithID:OrderNoCellID];
    if (orderNoCell) [section00 addObject:orderNoCell];
    if (section00.count>0) [sections addObject:section00];
    
    NSMutableArray *section01 = [NSMutableArray array];
    if (self.data.deliver) {
        ProductOrderTicketDetailDeliverCell *deliverCell = [self cellWithID:DeliverCellID];
        if (deliverCell) [section01 addObject:deliverCell];
    }
    if (section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    if (self.data.userAddressInfo) {
        ProductOrderTicketDetailAddressCell *addressCell = [self cellWithID:AddressCellID];
        if (addressCell) [section02 addObject:addressCell];
    }
    if (section02.count>0) [sections addObject:section02];
    
    NSMutableArray *section03 = [NSMutableArray array];
    ProductOrderTicketDetailProductCell *productCell = [self cellWithID:ProductCellID];
    if (productCell) [section03 addObject:productCell];
    if (section03.count>0) [sections addObject:section03];
    
    NSMutableArray *sectionForSeat = [NSMutableArray array];
    if (self.data.seats.count>0) {
        [self.data.seats enumerateObjectsUsingBlock:^(ProductOrderTicketDetailSeat *obj, NSUInteger idx, BOOL *stop) {
            ProductOrderTicketDetailEmptyCell *seatEmptyCell = [self cellWithID:EmptyCellID];
            if (seatEmptyCell) [sectionForSeat addObject:seatEmptyCell];
            ProductOrderTicketDetailSeatCell *seatCell = [self cellWithID:SeatCellID];
            seatCell.tag = idx;
            if (seatCell) [sectionForSeat addObject:seatCell];
        }];
        ProductOrderTicketDetailEmptyCell *seatEmptyCell = [self cellWithID:EmptyCellID];
        if (seatEmptyCell) [sectionForSeat addObject:seatEmptyCell];
    }
    if (sectionForSeat.count>0) [sections addObject:sectionForSeat];
    
    NSMutableArray *sectionForTime = [NSMutableArray array];
    if ([self.data.showTime isNotNull]) {
        ProductOrderTicketDetailTimeCell *timeCell = [self cellWithID:TimeCellID];
        if (timeCell) [sectionForTime addObject:timeCell];
    }
    if ([self.data.address isNotNull] || [self.data.mapAddress isNotNull]) {
        ProductOrderTicketDetailTheatherAddressCell *theatherAddressCell = [self cellWithID:TheatherAddressCellID];
        if (theatherAddressCell) [sectionForTime addObject:theatherAddressCell];
    }
    if (self.data.supplierPhones.count>0) {
        ProductOrderTicketDetailContactCell *concactCell = [self cellWithID:ContactCellID];
        if (concactCell) [sectionForTime addObject:concactCell];
    }
    if (sectionForTime.count>0) [sections addObject:sectionForTime];
    
    NSMutableArray *sectionForUserRemark = [NSMutableArray array];
    if (self.data.userRemarkStr.length>0) {
        ProductOrderTicketDetailUserRemarkCell *userRemarkCell = [self cellWithID:UserRemarkCellID];
        if (userRemarkCell) [sectionForUserRemark addObject:userRemarkCell];
    }
    if (sectionForUserRemark.count>0) [sections addObject:sectionForUserRemark];
    
    NSMutableArray *section04 = [NSMutableArray array];
    ProductOrderTicketDetailPayInfoTitleCell *payInfoTitleCell = [self cellWithID:PayInfoTitleCellID];
    if (payInfoTitleCell) [section04 addObject:payInfoTitleCell];
    
    ProductOrderTicketDetailEmptyCell *payInfoEmptyCell_price = [self cellWithID:EmptyCellID];
    if (payInfoEmptyCell_price) [section04 addObject:payInfoEmptyCell_price];
    ProductOrderTicketDetailPayInfoCell *payInfoCell_price = [self cellWithID:PayInfoCellID];
    payInfoCell_price.type = ProductOrderTicketDetailPayInfoCellTypeTypePrice;
    if (payInfoCell_price) [section04 addObject:payInfoCell_price];
    
    ProductOrderTicketDetailEmptyCell *payInfoEmptyCell_promotion = [self cellWithID:EmptyCellID];
    if (payInfoEmptyCell_promotion) [section04 addObject:payInfoEmptyCell_promotion];
    ProductOrderTicketDetailPayInfoCell *payInfoCell_promotion = [self cellWithID:PayInfoCellID];
    payInfoCell_promotion.type = ProductOrderTicketDetailPayInfoCellTypeTypePromotion;
    if (payInfoCell_promotion) [section04 addObject:payInfoCell_promotion];
    
    ProductOrderTicketDetailEmptyCell *payInfoEmptyCell_score = [self cellWithID:EmptyCellID];
    if (payInfoEmptyCell_score) [section04 addObject:payInfoEmptyCell_score];
    ProductOrderTicketDetailPayInfoCell *payInfoCell_score = [self cellWithID:PayInfoCellID];
    payInfoCell_score.type = ProductOrderTicketDetailPayInfoCellTypeTypeScore;
    if (payInfoCell_score) [section04 addObject:payInfoCell_score];
    
    if (self.data.transportationExpenses>0) {
        ProductOrderTicketDetailEmptyCell *payInfoEmptyCell_transportationExpenses = [self cellWithID:EmptyCellID];
        if (payInfoEmptyCell_transportationExpenses) [section04 addObject:payInfoEmptyCell_transportationExpenses];
        ProductOrderTicketDetailPayInfoCell *payInfoCell_transportationExpenses = [self cellWithID:PayInfoCellID];
        payInfoCell_transportationExpenses.type = ProductOrderTicketDetailPayInfoCellTypeTransportationExpenses;
        if (payInfoCell_transportationExpenses) [section04 addObject:payInfoCell_transportationExpenses];
    }
    
    ProductOrderTicketDetailEmptyCell *payInfoEmptyCell_last = [self cellWithID:EmptyCellID];
    if (payInfoEmptyCell_last) [section04 addObject:payInfoEmptyCell_last];
    
    ProductOrderTicketDetailPayInfoTotalCell *payInfoTotalCell = [self cellWithID:PayInfoTotalCellID];
    if(payInfoTotalCell) [section04 addObject:payInfoTotalCell];
    
    if (section04.count>0) [sections addObject:section04];
    
    NSMutableArray *section05 = [NSMutableArray array];
    if (self.data.remarks.count>0) {
        ProductOrderTicketDetailRemarkCell *remarkCell = [self cellWithID:RemarkCellID];
        if (remarkCell) [section05 addObject:remarkCell];
    }
    if (section05.count>0) [sections addObject:section05];
    
    NSMutableArray *section07 = [NSMutableArray array];
    if (self.data.refunds.count>0) {
        ProductOrderTicketDetailRefundTitleCell *refundTitleCell = [self cellWithID:RefundTitleCellID];
        if(refundTitleCell) [section07 addObject:refundTitleCell];
        [self.data.refunds enumerateObjectsUsingBlock:^(ProductOrderTicketDetailRefund *obj, NSUInteger idx, BOOL *stop) {
            ProductOrderTicketDetailRefundCell *refundCell = [self cellWithID:RefundCellID];
            refundCell.tag = idx;
            if (refundCell) [section07 addObject:refundCell];
        }];
    }
    if (section07.count>0) [sections addObject:section07];
    
    
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
        NSArray<ProductOrderTicketDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            ProductOrderTicketDetailBaseCell *cell = rows[row];
            cell.data = self.data;
            cell.delegate = self;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark - ProductOrderTicketDetailBaseCellDelegate

- (void)productOrderTicketDetailBaseCell:(ProductOrderTicketDetailBaseCell *)cell actionType:(ProductOrderTicketDetailBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderTicketDetailView:actionType:value:)]) {
        [self.delegate productOrderTicketDetailView:self actionType:(ProductOrderTicketDetailViewActionType)type value:value];
    }
}

- (void)setupToolBar {
    ProductOrderTicketDetailToolBar *toolBar = [self viewWithNib:@"ProductOrderTicketDetailToolBar"];
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT - kProductOrderTicketDetailToolBarH, SCREEN_WIDTH, kProductOrderTicketDetailToolBarH);
    toolBar.delegate = self;
    toolBar.hidden = YES;
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma marl - ProductOrderTicketDetailToolBarDelegate

- (void)productOrderTicketDetailToolBar:(ProductOrderTicketDetailToolBar *)toolBar actionType:(ProductOrderTicketDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderTicketDetailView:actionType:value:)]) {
        [self.delegate productOrderTicketDetailView:self actionType:(ProductOrderTicketDetailViewActionType)type value:value];
    }
}

#pragma mark - ProductOrderNormalDetailHeaderDelegate

- (void)productOrderNormalDetailHeader:(ProductOrderNormalDetailHeader *)header actionType:(ProductOrderNormalDetailHeaderActionType)type {
    switch (type) {
        case ProductOrderNormalDetailHeaderActionTypeClose:
        {
            self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.001)];
        }
            break;
        case ProductOrderNormalDetailHeaderActionTypeShowRule:
        {
            if ([self.delegate respondsToSelector:@selector(productOrderTicketDetailView:actionType:value:)]) {
                [self.delegate productOrderTicketDetailView:self actionType:ProductOrderTicketDetailViewActionTypeShowRule value:self.data];
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
