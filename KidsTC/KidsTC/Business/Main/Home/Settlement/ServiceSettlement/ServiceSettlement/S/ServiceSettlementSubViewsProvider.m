//
//  ServiceSettlementSubViewsProvider.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementSubViewsProvider.h"

#import "ServiceSettlementBaseCell.h"
#import "ServiceSettlementTipAddressCell.h"
#import "ServiceSettlementAddressCell.h"
#import "ServiceSettlementServiceInfoCell.h"
#import "ServiceSettlementStoreInfoCell.h"
#import "ServiceSettlementBuyNumCell.h"
#import "ServiceSettlementCouponCell.h"
#import "ServiceSettlementPayTypeCell.h"
#import "ServiceSettlementPayInfoCell.h"
#import "ServiceSettlementTicketPriceCell.h"
#import "ServiceSettlementTicketGetCell.h"
#import "ServiceSettlementTicketGetSelfCell.h"

@interface ServiceSettlementSubViewsProvider ()
@property (nonatomic,   weak) ServiceSettlementToolBar              *tooBar;

@property (nonatomic, strong) ServiceSettlementTipAddressCell       *tipAddressCell;
@property (nonatomic, strong) ServiceSettlementAddressCell          *addressCell;
@property (nonatomic, strong) ServiceSettlementServiceInfoCell      *serviceInfoCell;
@property (nonatomic, strong) ServiceSettlementBuyNumCell           *buyNumCell;
@property (nonatomic, strong) ServiceSettlementStoreInfoCell        *storeInfoCell;
@property (nonatomic, strong) ServiceSettlementCouponCell           *couponCell;
@property (nonatomic, strong) ServiceSettlementPayTypeCell          *payTypeCell;
@property (nonatomic, strong) ServiceSettlementTicketGetCell        *ticketGetCell;
@property (nonatomic, strong) ServiceSettlementTicketGetSelfCell    *ticketGetSelfCell;
@end

@implementation ServiceSettlementSubViewsProvider
singleM(ServiceSettlementSubViewsProvider)

- (NSArray<NSArray<ServiceSettlementBaseCell *> *> *)sections {

    switch (self.type) {
        case ProductDetailTypeNormal:
        {
            return self.normalSections;
        }
            break;
        case ProductDetailTypeTicket:
        {
            return self.ticketSections;
        }
            break;
        case ProductDetailTypeFree:
        {
            return self.normalSections;
        }
            break;
    }
}

- (NSArray<NSArray<ServiceSettlementBaseCell *> *> *)normalSections{
    
    if (!self.model.data) {
        return nil;
    }
    
    ServiceSettlementDataItem *item = self.model.data;
    NSMutableArray<NSMutableArray<ServiceSettlementBaseCell *> *> *sections = [NSMutableArray<NSMutableArray<ServiceSettlementBaseCell *> *> array];
    //收货地址
    if (item.hasUserAddress) {
        NSMutableArray<ServiceSettlementBaseCell *> *section00 = [NSMutableArray array];
        if (item.userAddress) {
            [section00 addObject:self.addressCell];
        }else{
            [section00 addObject:self.tipAddressCell];
        }
        [sections addObject:section00];
    }
    //商品、门店
    NSMutableArray<ServiceSettlementBaseCell *> *section01 = [NSMutableArray array];
    [section01 addObject:self.serviceInfoCell];
    [section01 addObject:self.buyNumCell];
    if (item.store && item.store.storeDesc.length>0) {
        [section01 addObject:self.storeInfoCell];
    }
    [sections addObject:section01];
    //优惠券、积分
    NSMutableArray<ServiceSettlementBaseCell *> *section02 = [NSMutableArray array];
    [section02 addObject:self.couponCell];
    [sections addObject:section02];
    //选择支付类型
    NSMutableArray<ServiceSettlementBaseCell *> *section03 = [NSMutableArray array];
    [section03 addObject:self.payTypeCell];
    [sections addObject:section03];
    //结算信息
    NSMutableArray<ServiceSettlementBaseCell *> *section04 = [NSMutableArray array];
    ServiceSettlementPayInfoCell *pricePayInfoCell = self.payInfoCell;
    pricePayInfoCell.type = ServiceSettlementPayInfoCellTypePrice;
    [section04 addObject:pricePayInfoCell];
    ServiceSettlementPayInfoCell *promotionPayInfoCell = self.payInfoCell;
    promotionPayInfoCell.type = ServiceSettlementPayInfoCellTypePromotion;
    [section04 addObject:promotionPayInfoCell];
    ServiceSettlementPayInfoCell *scorePayInfoCell = self.payInfoCell;
    scorePayInfoCell.type = ServiceSettlementPayInfoCellTypeScore;
    [section04 addObject:scorePayInfoCell];
    if (item.transportationExpenses>0) {
        ServiceSettlementPayInfoCell *transportationExpensesPayInfoCell = self.payInfoCell;
        transportationExpensesPayInfoCell.type = ServiceSettlementPayInfoCellTypeTransportationExpenses;
        [section04 addObject:transportationExpensesPayInfoCell];
    }
    [sections addObject:section04];
    
    return [NSArray arrayWithArray:sections];
}

- (NSArray<NSArray<ServiceSettlementBaseCell *> *> *)ticketSections{
    if (!self.model.data) {
        return nil;
    }
    ServiceSettlementDataItem *item = self.model.data;
    NSMutableArray<NSMutableArray<ServiceSettlementBaseCell *> *> *sections = [NSMutableArray<NSMutableArray<ServiceSettlementBaseCell *> *> array];
    
    //商品、价格
    NSMutableArray<ServiceSettlementBaseCell *> *section01 = [NSMutableArray array];
    [section01 addObject:self.serviceInfoCell];
    [item.seats enumerateObjectsUsingBlock:^(ServiceSettlementSeat *obj, NSUInteger idx, BOOL *stop) {
        ServiceSettlementTicketPriceCell *ticketPriceCell = self.ticketPriceCell;
        ticketPriceCell.seat = obj;
        [section01 addObject:ticketPriceCell];
    }];
    [sections addObject:section01];
    
    //取票方式
    NSMutableArray<ServiceSettlementBaseCell *> *section00 = [NSMutableArray array];
    [section00 addObject:self.ticketGetCell];
    switch (item.takeTicketWay) {
        case ServiceSettlementTakeTicketWayCar:
        {
            if (item.userAddress) {
                [section00 addObject:self.addressCell];
            }else{
                [section00 addObject:self.tipAddressCell];
            }
        }
            break;
        case ServiceSettlementTakeTicketWaySelf:
        {
            [section00 addObject:self.ticketGetSelfCell];
        }
            break;
    }
    [sections addObject:section00];
    
    //优惠券、积分
    NSMutableArray<ServiceSettlementBaseCell *> *section02 = [NSMutableArray array];
    [section02 addObject:self.couponCell];
    [sections addObject:section02];
    //选择支付类型
    NSMutableArray<ServiceSettlementBaseCell *> *section03 = [NSMutableArray array];
    [section03 addObject:self.payTypeCell];
    [sections addObject:section03];
    //结算信息
    NSMutableArray<ServiceSettlementBaseCell *> *section04 = [NSMutableArray array];
    ServiceSettlementPayInfoCell *pricePayInfoCell = self.payInfoCell;
    pricePayInfoCell.type = ServiceSettlementPayInfoCellTypePrice;
    [section04 addObject:pricePayInfoCell];
    ServiceSettlementPayInfoCell *promotionPayInfoCell = self.payInfoCell;
    promotionPayInfoCell.type = ServiceSettlementPayInfoCellTypePromotion;
    [section04 addObject:promotionPayInfoCell];
    ServiceSettlementPayInfoCell *scorePayInfoCell = self.payInfoCell;
    scorePayInfoCell.type = ServiceSettlementPayInfoCellTypeScore;
    [section04 addObject:scorePayInfoCell];
    if (item.transportationExpenses>0) {
        ServiceSettlementPayInfoCell *transportationExpensesPayInfoCell = self.payInfoCell;
        transportationExpensesPayInfoCell.type = ServiceSettlementPayInfoCellTypeTransportationExpenses;
        [section04 addObject:transportationExpensesPayInfoCell];
    }
    [sections addObject:section04];
    
    return [NSArray arrayWithArray:sections];
}

- (ServiceSettlementTipAddressCell *)tipAddressCell {
    if (!_tipAddressCell) {
        _tipAddressCell = [self viewWithNib:@"ServiceSettlementTipAddressCell"];
    }
    return _tipAddressCell;
}
- (ServiceSettlementAddressCell *)addressCell {
    if (!_addressCell) {
        _addressCell = [self viewWithNib:@"ServiceSettlementAddressCell"];
    }
    return _addressCell;
}
- (ServiceSettlementServiceInfoCell *)serviceInfoCell {
    if (!_serviceInfoCell) {
        _serviceInfoCell = [self viewWithNib:@"ServiceSettlementServiceInfoCell"];
    }
    return _serviceInfoCell;
}
- (ServiceSettlementStoreInfoCell *)storeInfoCell {
    if (!_storeInfoCell) {
        _storeInfoCell = [self viewWithNib:@"ServiceSettlementStoreInfoCell"];
    }
    return _storeInfoCell;
}
- (ServiceSettlementBuyNumCell *)buyNumCell {
    if (!_buyNumCell) {
        _buyNumCell = [self viewWithNib:@"ServiceSettlementBuyNumCell"];
    }
    return _buyNumCell;
}
- (ServiceSettlementCouponCell *)couponCell {
    if (!_couponCell) {
        _couponCell = [self viewWithNib:@"ServiceSettlementCouponCell"];
    }
    return _couponCell;
}
- (ServiceSettlementPayTypeCell *)payTypeCell {
    if (!_payTypeCell) {
        _payTypeCell = [self viewWithNib:@"ServiceSettlementPayTypeCell"];
    }
    return _payTypeCell;
}
- (ServiceSettlementPayInfoCell *)payInfoCell {
    return [self viewWithNib:@"ServiceSettlementPayInfoCell"];
}
- (ServiceSettlementTicketPriceCell *)ticketPriceCell {
    return [self viewWithNib:@"ServiceSettlementTicketPriceCell"];
}
- (ServiceSettlementTicketGetCell *)ticketGetCell {
    if (!_ticketGetCell) {
        _ticketGetCell = [self viewWithNib:@"ServiceSettlementTicketGetCell"];
    }
    return _ticketGetCell;
}
- (ServiceSettlementTicketGetSelfCell *)ticketGetSelfCell {
    if (!_ticketGetSelfCell) {
        _ticketGetSelfCell = [self viewWithNib:@"ServiceSettlementTicketGetSelfCell"];
    }
    return _ticketGetSelfCell;
}

- (ServiceSettlementToolBar *)tooBar {
    if (!_tooBar) {
        _tooBar = [self viewWithNib:@"ServiceSettlementToolBar"];
    }
    return _tooBar;
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (void)nilCells {
    _tipAddressCell = nil;
    _addressCell = nil;
    _serviceInfoCell = nil;
    _buyNumCell = nil;
    _storeInfoCell = nil;
    _couponCell = nil;
    _payTypeCell = nil;
    _ticketGetCell = nil;
    _ticketGetSelfCell = nil;
}

@end
