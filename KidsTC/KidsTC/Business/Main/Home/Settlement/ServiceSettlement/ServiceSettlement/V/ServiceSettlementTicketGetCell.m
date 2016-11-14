//
//  ServiceSettlementTicketGetCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

static CGFloat const img_h = 28;
static CGFloat const title_h = 17;
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
    return CGRectMake(0, CGRectGetHeight(contentRect) - title_b - title_h, CGRectGetWidth(contentRect), title_h);
}

@end

#import "ServiceSettlementTicketGetCell.h"

@interface ServiceSettlementTicketGetCell ()
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
    _lineH.constant = LINE_H;
    [self.carBtn setTitleColor:COLOR_PINK forState:UIControlStateSelected];
    [self.selfBtn setTitleColor:COLOR_PINK forState:UIControlStateSelected];
    [self selectedBtn:_carBtn];
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    [super setItem:item];
    switch (item.ticketGetType) {
        case TicketGetTypeCar:
        {
            [self selectedBtn:_carBtn];
        }
            break;
        case TicketGetTypeSelf:
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
    if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
        [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeTicketGetTypeDidChange value:nil];
    }
}

- (void)selectedBtn:(ServiceSettlementTicketGetButton *)sender {
    if (sender == _carBtn) {
        _upImgCenterX.constant = 0;
        self.item.ticketGetType = TicketGetTypeCar;
    }else if (sender == _selfBtn) {
        _upImgCenterX.constant = 80;
        self.item.ticketGetType = TicketGetTypeSelf;
    }
    [self layoutIfNeeded];
    _selectBtn.selected = NO;
    sender.selected = YES;
    _selectBtn = sender;
}


@end
