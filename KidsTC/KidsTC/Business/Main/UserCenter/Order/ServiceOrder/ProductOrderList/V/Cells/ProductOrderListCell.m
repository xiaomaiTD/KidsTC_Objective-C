//
//  ProductOrderListCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListCell.h"
#import "ProductOrderListCellBtnsView.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"
#import "YYKit.h"
#import "Colours.h"

@interface ProductOrderListCell ()<ProductOrderListCellBtnsViewDelegate>
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
@property (weak, nonatomic) IBOutlet ProductOrderListCellBtnsView *btnsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsViewH;

@end

@implementation ProductOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _storeBtn.tag = ProductOrderListCellActionTypeStore;
    _imageIcon.layer.cornerRadius = 4;
    _imageIcon.layer.masksToBounds = YES;
    _imageIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _imageIcon.layer.borderWidth = LINE_H;
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
    
    _btnsView.delegate = self;
}

- (void)setItem:(ProductOrderListItem *)item {
    _item = item;
    self.storeNameL.text = _item.storeName;
    self.statusNameL.text = _item.statusName;
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:_item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    [self countDown];
    self.realPriceTipL.text = _item.payDesc;
    self.realPriceL.text = [NSString stringWithFormat:@"¥%@",_item.payPrice];
    
    if (_item.btns.count>0) {
        self.btnsView.btnsAry = _item.btns;
        self.btnsView.hidden = NO;
        self.btnsViewH.constant = 46;
    }else{
        self.btnsView.hidden = YES;
        self.btnsViewH.constant = 0;
    }
    
    switch (_item.orderKind) {
        case OrderKindTicket:
        {
            self.storeArrowImg.hidden = YES;
            self.normalBGView.hidden = YES;
            self.ticketBGView.hidden = NO;
            self.ticketNameL.text = _item.productName;
            self.ticketTimeL.text = _item.createTime;
            self.ticketCountL.text = _item.payNum;
            self.ticketPriceL.text = [NSString stringWithFormat:@"¥%@",_item.unitPrice];
            self.theaterNameL.text = _item.venueName;
        }
            break;
            
        default:
        {
            switch (_item.placeType) {
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
            self.productNameL.text = _item.productName;
            self.countL.text = [NSString stringWithFormat:@"x%@",_item.payNum];
            self.priceL.text = [NSString stringWithFormat:@"¥%@",_item.unitPrice];
            self.remarkL.text = _item.reservationRemark;
            self.timeL.text = _item.createTime;
        }
            break;
    }
    
    ProductOrderListDeliver *deliver = _item.deliver;
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
    NSMutableAttributedString *attDeliverInfo = [[NSMutableAttributedString alloc] initWithString:_item.deliver.deliverStr];
    attDeliverInfo.color = [UIColor colorFromHexString:@"555555"];
    attDeliverInfo.font = [UIFont systemFontOfSize:12];
    attDeliverInfo.lineSpacing = 6;
    [_item.deliver.items enumerateObjectsUsingBlock:^(ProductOrderListDeliverItem *obj, NSUInteger idx, BOOL *stop) {
        StrongSelf(self)
        NSRange range = [_item.deliver.deliverStr rangeOfString:obj.value];
        if ((obj.isCall&&[obj.value isNotNull])||(obj.segueModel.destination != SegueDestinationNone)) {
            [attDeliverInfo setUnderlineStyle:NSUnderlineStyleSingle range:range];
        }
        UIColor *color = [UIColor colorFromHexString:obj.color];
        if (!color) color = COLOR_PINK;
        [attDeliverInfo setTextHighlightRange:range
                                        color:color
                              backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                    tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                        if (![self.delegate respondsToSelector:@selector(productOrderListCell:actionType:value:)]) return;
                                        if (obj.isCall) {
                                            if (![obj.value isNotNull]) return;
                                            [self.delegate productOrderListCell:self actionType:ProductOrderListCellActionTypeCall value:obj.value];
                                        }else{
                                            [self.delegate productOrderListCell:self actionType:ProductOrderListCellActionTypeSegue value:obj.segueModel];
                                        }
                                    }];
    }];
    self.deliverL.attributedText = attDeliverInfo;
    self.deliverPlaceL.attributedText = attDeliverInfo;
    self.deliverBGViewH.constant = [attDeliverInfo boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 50, 99999) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 18;
}

- (void)countDown {
    ProductOrderListCountDown *countDown = self.item.countDown;
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
            if ([self.delegate respondsToSelector:@selector(productOrderListCell:actionType:value:)]) {
                [self.delegate productOrderListCell:self actionType:ProductOrderListCellActionTypeCountDownOver value:_item];
            }
        }
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

- (IBAction)action:(UIButton *)sender {
    if (_item.orderKind == OrderKindTicket) return;
    if (_item.placeType != PlaceTypeStore) return;
    if ([self.delegate respondsToSelector:@selector(productOrderListCell:actionType:value:)]) {
        [self.delegate productOrderListCell:self actionType:(ProductOrderListCellActionType)sender.tag value:_item];
    }
}


#pragma mark - ProductOrderListCellBtnsViewDelegate

- (void)productOrderListCellBtnsView:(ProductOrderListCellBtnsView *)view actionBtn:(UIButton *)btn value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderListCell:actionType:value:)]) {
        [self.delegate productOrderListCell:self actionType:(ProductOrderListCellActionType)btn.tag value:_item];
    }
}



@end
