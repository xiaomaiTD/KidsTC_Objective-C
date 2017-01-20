//
//  ServiceSettlementTicketGetCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

static CGFloat const img_h = 20;
static CGFloat const title_h = 13;
static CGFloat const title_b = 4;

@interface ServiceSettlementTicketGetButton : UIButton

@end

@implementation ServiceSettlementTicketGetButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, CGRectGetWidth(contentRect), img_h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake((CGRectGetWidth(contentRect)-80)*0.5, CGRectGetHeight(contentRect) - title_b - title_h, 80, title_h);
}

@end

#import "ServiceSettlementTicketGetCell.h"

@interface ServiceSettlementTicketGetCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet ServiceSettlementTicketGetButton *carBtn;
@property (weak, nonatomic) IBOutlet ServiceSettlementTicketGetButton *selfBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upImgCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@property (weak, nonatomic) IBOutlet UIView *line;
@end

@implementation ServiceSettlementTicketGetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipL.textColor = [UIColor colorFromHexString:@"222222"];
    [self.carBtn setTitleColor:[UIColor colorFromHexString:@"D5D5D5"] forState:UIControlStateNormal];
    [self.carBtn setTitleColor:COLOR_PINK forState:UIControlStateSelected];
    [self.selfBtn setTitleColor:[UIColor colorFromHexString:@"D5D5D5"] forState:UIControlStateNormal];
    [self.selfBtn setTitleColor:COLOR_PINK forState:UIControlStateSelected];
    _lineH.constant = LINE_H;
    [self selectedBtn:_selfBtn];
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    [super setItem:item];
    
    self.carBtn.enabled = item.isSupportExpress;
    self.selfBtn.enabled = item.isSupportSiteTickets;
    
    switch (item.takeTicketWay) {
        case ServiceSettlementTakeTicketWayCar:
        {
            [self selectedBtn:_carBtn];
        }
            break;
        case ServiceSettlementTakeTicketWaySelf:
        {
            [self selectedBtn:_selfBtn];
        }
            break;
    }
}

- (IBAction)action:(ServiceSettlementTicketGetButton *)sender {
    if (_selectBtn == sender) {
        return;
    }
    [self selectedBtn:sender];
    if (sender == _selfBtn) {
        self.item.takeTicketWay = ServiceSettlementTakeTicketWaySelf;
    }else if (sender == _carBtn) {
        self.item.takeTicketWay = ServiceSettlementTakeTicketWayCar;
    }
    if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
        [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeTicketGetTypeDidChange value:nil];
    }
}

- (void)selectedBtn:(ServiceSettlementTicketGetButton *)sender {
    if (sender == _selfBtn) {
        _upImgCenterX.constant = 0;
    }else if (sender == _carBtn) {
        _upImgCenterX.constant = 78;
    }
    [self layoutIfNeeded];
    _selectBtn.selected = NO;
    sender.selected = YES;
    _selectBtn = sender;
}


@end
