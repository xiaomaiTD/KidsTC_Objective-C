//
//  RadishProductOrderListCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductOrderListInfoCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"
#import "YYKit.h"
#import "Colours.h"

@interface RadishProductOrderListInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *storeIcon;
@property (weak, nonatomic) IBOutlet UILabel *storeNameL;
@property (weak, nonatomic) IBOutlet UIImageView *storeArrowImg;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusNameL;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;

@property (weak, nonatomic) IBOutlet UILabel *realPriceTipL;
@property (weak, nonatomic) IBOutlet UILabel *realPriceL;

@property (weak, nonatomic) IBOutlet UIView *deliverBGView;
@property (weak, nonatomic) IBOutlet UILabel *deliverPlaceL;
@property (weak, nonatomic) IBOutlet YYLabel *deliverL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deliverBGViewH;


@property (weak, nonatomic) IBOutlet UIView *normalBGView;
@property (weak, nonatomic) IBOutlet UILabel *productNameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *remarkL;


@property (weak, nonatomic) IBOutlet UIView *ticketBGView;
@property (weak, nonatomic) IBOutlet UILabel *ticketNameL;
@property (weak, nonatomic) IBOutlet UILabel *theaterNameL;
@property (weak, nonatomic) IBOutlet UILabel *ticketCountL;
@property (weak, nonatomic) IBOutlet UILabel *ticketPriceL;
@property (weak, nonatomic) IBOutlet UILabel *ticketTimeL;


@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet UIImageView *countDownIcon;

@end

@implementation RadishProductOrderListInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _storeBtn.tag = RadishProductOrderListBaseCellActionTypeStore;
    _imageIcon.layer.cornerRadius = 4;
    _imageIcon.layer.masksToBounds = YES;
    _imageIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _imageIcon.layer.borderWidth = LINE_H;
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setItem:(RadishProductOrderListItem *)item {
    [super setItem:item];
    self.storeNameL.text = self.item.storeName;
    self.statusNameL.text = self.item.statusName;
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:self.item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    [self countDown];
    self.realPriceTipL.text = self.item.payDesc;
    self.realPriceL.text = [NSString stringWithFormat:@"¥%@",self.item.payPrice];
    
    switch (self.item.orderKind) {
        case OrderKindTicket:
        {
            self.storeArrowImg.hidden = YES;
            self.normalBGView.hidden = YES;
            self.ticketBGView.hidden = NO;
            self.ticketNameL.text = self.item.productName;
            self.ticketTimeL.text = self.item.createTime;
            self.ticketCountL.text = self.item.payNum;
            self.ticketPriceL.text = [NSString stringWithFormat:@"¥%@",self.item.unitPrice];
            self.theaterNameL.text = self.item.venueName;
        }
            break;
            
        default:
        {
            switch (self.item.placeType) {
                case PlaceTypeStore:
                {
                    self.storeIcon.hidden = NO;
                    self.storeArrowImg.hidden = NO;
                    self.storeNameL.hidden = NO;
                }
                    break;
                case PlaceTypeNone:
                {
                    self.storeIcon.hidden = YES;
                    self.storeArrowImg.hidden = YES;
                    self.storeNameL.hidden = YES;
                }
                    break;
                default:
                {
                    self.storeIcon.hidden = NO;
                    self.storeArrowImg.hidden = YES;
                    self.storeNameL.hidden = NO;
                }
                    break;
            }
            
            self.normalBGView.hidden = NO;
            self.ticketBGView.hidden = YES;
            self.productNameL.text = self.item.productName;
            self.countL.text = [NSString stringWithFormat:@"x%@",self.item.payNum];
            self.priceL.text = [NSString stringWithFormat:@"¥%@",self.item.unitPrice];
            self.remarkL.text = self.item.reservationRemark;
            self.timeL.text = self.item.createTime;
        }
            break;
    }
    
    RadishProductOrderListDeliver *deliver = self.item.deliver;
    if ([deliver.deliverStr isNotNull]) {
        self.deliverBGView.hidden = NO;
        [self settupDeliverInfo];
    }else{
        self.deliverBGView.hidden = YES;
        self.deliverBGViewH.constant = 0;
        self.deliverL.attributedText = nil;
        self.deliverPlaceL.attributedText = nil;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)settupDeliverInfo {
    WeakSelf(self)
    NSMutableAttributedString *attDeliverInfo = [[NSMutableAttributedString alloc] initWithString:self.item.deliver.deliverStr];
    attDeliverInfo.color = [UIColor colorFromHexString:@"555555"];
    attDeliverInfo.font = [UIFont systemFontOfSize:12];
    attDeliverInfo.lineSpacing = 6;
    [self.item.deliver.items enumerateObjectsUsingBlock:^(RadishProductOrderListDeliverItem *obj, NSUInteger idx, BOOL *stop) {
        StrongSelf(self)
        NSRange range = [self.item.deliver.deliverStr rangeOfString:obj.value];
        if ((obj.isCall&&[obj.value isNotNull])||(obj.segueModel.destination != SegueDestinationNone)) {
            [attDeliverInfo setUnderlineStyle:NSUnderlineStyleSingle range:range];
        }
        UIColor *color = [UIColor colorFromHexString:obj.color];
        if (!color) color = COLOR_PINK;
        [attDeliverInfo setTextHighlightRange:range
                                        color:color
                              backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                    tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                        if (![self.delegate respondsToSelector:@selector(radishProductOrderListBaseCell:actionType:value:)]) return;
                                        if (obj.isCall) {
                                            if (![obj.value isNotNull]) return;
                                            [self.delegate radishProductOrderListBaseCell:self actionType:RadishProductOrderListBaseCellActionTypeCall value:obj.value];
                                        }else{
                                            [self.delegate radishProductOrderListBaseCell:self actionType:RadishProductOrderListBaseCellActionTypeSegue value:obj.segueModel];
                                        }
                                    }];
    }];
    self.deliverL.attributedText = attDeliverInfo;
    self.deliverPlaceL.attributedText = attDeliverInfo;
    self.deliverBGViewH.constant = [attDeliverInfo boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 50, 99999) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 18;
}

- (void)countDown {
    RadishProductOrderListCountDown *countDown = self.item.countDown;
    NSString *str = countDown.countDownValueString;
    if ([str isNotNull]) {
        _countDownIcon.hidden = NO;
        _countDownL.hidden = NO;
        _countDownL.text = str;
    }else{
        _countDownIcon.hidden = YES;
        _countDownL.hidden = YES;
        if (countDown.showCountDown && !countDown.countDownOver) {
            countDown.countDownOver = YES;
            if ([self.delegate respondsToSelector:@selector(radishProductOrderListBaseCell:actionType:value:)]) {
                [self.delegate radishProductOrderListBaseCell:self actionType:RadishProductOrderListBaseCellActionTypeCountDownOver value:self.item];
            }
        }
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

- (IBAction)action:(UIButton *)sender {
    if (self.item.orderKind == OrderKindTicket) return;
    if (self.item.placeType != PlaceTypeStore) return;
    if ([self.delegate respondsToSelector:@selector(radishProductOrderListBaseCell:actionType:value:)]) {
        [self.delegate radishProductOrderListBaseCell:self actionType:(RadishProductOrderListBaseCellActionType)sender.tag value:self.item];
    }
}

@end
