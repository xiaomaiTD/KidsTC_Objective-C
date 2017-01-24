//
//  ServiceSettlementTicketGetCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//



#import "ServiceSettlementTicketGetCell.h"

#import "ServiceSettlementTicketGetItem.h"

@interface ServiceSettlementTicketGetCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderLeading;

@property (nonatomic, strong) NSArray<ServiceSettlementTicketGetItem *> *itemsAry;
@end

@implementation ServiceSettlementTicketGetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipL.textColor = [UIColor colorFromHexString:@"222222"];
    _lineH.constant = LINE_H;
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat item_s = 63;
    CGFloat margin = 15;
    [self.itemsAry enumerateObjectsUsingBlock:^(ServiceSettlementTicketGetItem *obj, NSUInteger idx, BOOL *stop) {
        obj.frame = CGRectMake(15+(item_s+margin)*idx, 47, item_s, item_s);
    }];
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    [super setItem:item];
    
    [self.itemsAry makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemsAry = nil;
    
    NSMutableArray *ary = [NSMutableArray array];
    if (item.isSupportSiteTickets) {
        ServiceSettlementTicketGetItem *itemBtn =
        [ServiceSettlementTicketGetItem itemWithTitle:@"现场取票"
                                             norImage:@"ticket_get_self_n"
                                             selImage:@"ticket_get_self_s"
                                            norCorlor:@"D5D5D5"
                                            selCorlor:@"ff8888"
                                        takeTicketWay:ServiceSettlementTakeTicketWaySelf
                                          actionBlock:^(ServiceSettlementTicketGetItem *obj){
                                              [self itemAction:obj];
                                          }];
        if (itemBtn) {
            [self.contentView addSubview:itemBtn];
            [ary addObject:itemBtn];
        }
    }
    if (item.isSupportExpress) {
        ServiceSettlementTicketGetItem *itemBtn =
        [ServiceSettlementTicketGetItem itemWithTitle:@"快递"
                                             norImage:@"ticket_get_car_n"
                                             selImage:@"ticket_get_car_s"
                                            norCorlor:@"D5D5D5"
                                            selCorlor:@"ff8888"
                                        takeTicketWay:ServiceSettlementTakeTicketWayCar
                                          actionBlock:^(ServiceSettlementTicketGetItem *obj){
                                              [self itemAction:obj];
                                          }];
        if (itemBtn) {
            [self.contentView addSubview:itemBtn];
            [ary addObject:itemBtn];
        }
    }
    self.itemsAry = [NSArray arrayWithArray:ary];
    
    [self layoutIfNeeded];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self selectItem:item.takeTicketWay];
    });
}


- (void)itemAction:(ServiceSettlementTicketGetItem *)item {
    if (item.select) return;
    self.item.takeTicketWay = item.takeTicketWay;
    //[self selectItem:item.takeTicketWay];
    if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
        [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeTicketGetTypeDidChange value:nil];
    }
}

- (void)selectItem:(ServiceSettlementTakeTicketWay)way {
    [self.itemsAry enumerateObjectsUsingBlock:^(ServiceSettlementTicketGetItem *obj, NSUInteger idx, BOOL *stop) {
        if (obj.takeTicketWay == way) {
            obj.select = YES;
            CGFloat leading = obj.center.x - self.sliderWidth.constant*0.5;
            self.sliderLeading.constant = leading;
            [self layoutIfNeeded];
        }else{
            obj.select = NO;
        }
    }];
}


@end
