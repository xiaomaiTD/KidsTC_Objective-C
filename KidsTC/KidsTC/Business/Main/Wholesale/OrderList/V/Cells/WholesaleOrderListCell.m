//
//  WholesaleOrderListCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderListCell.h"
#import "YYKit.h"
#import "WholesaleOrderListCellBtnsView.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface WholesaleOrderListCell ()<WholesaleOrderListCellBtnsViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *leaderIcon;
@property (weak, nonatomic) IBOutlet UILabel *leaderNameL;
@property (weak, nonatomic) IBOutlet UIImageView *leaderArrowImg;
@property (weak, nonatomic) IBOutlet UILabel *statusNameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;

@property (weak, nonatomic) IBOutlet UILabel *realPriceTipL;
@property (weak, nonatomic) IBOutlet UILabel *realPriceL;

@property (weak, nonatomic) IBOutlet UIView *normalBGView;
@property (weak, nonatomic) IBOutlet UILabel *productNameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet UIImageView *countDownIcon;
@property (weak, nonatomic) IBOutlet WholesaleOrderListCellBtnsView *btnsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsViewH;
@end

@implementation WholesaleOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.leaderIcon.layer.cornerRadius = CGRectGetWidth(self.leaderIcon.frame) * 0.5;
    self.leaderIcon.layer.masksToBounds = YES;
    self.leaderIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.leaderIcon.layer.borderWidth = LINE_H;
    self.imageIcon.layer.cornerRadius = 4;
    self.imageIcon.layer.masksToBounds = YES;
    self.imageIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.imageIcon.layer.borderWidth = LINE_H;
    self.btnsView.delegate = self;
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setItem:(WholesaleOrderListItem *)item {
    _item = item;
    
    [self.leaderIcon sd_setImageWithURL:[NSURL URLWithString:item.openGroupHeader] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.leaderNameL.text = item.openGroupUserName;
    self.tipL.text = item.surplusCountDesc;
    self.statusNameL.text = item.statusDesc;
    
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:_item.productImgae] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.productNameL.text = item.productName;
    self.priceL.text = [NSString stringWithFormat:@"¥%@",item.price];
    self.countL.text = [NSString stringWithFormat:@"x%@",item.count];
    self.timeL.text = item.orderTime;
    
    self.realPriceTipL.text = [NSString stringWithFormat:@"%@组成团价格:",item.fightGroupUserCount];
    self.realPriceL.text = [NSString stringWithFormat:@"¥%@",item.price];
    
    if (_item.orderBtns.count>0) {
        self.btnsView.btnsAry = _item.orderBtns;
        self.btnsView.hidden = NO;
        self.btnsViewH.constant = 46;
    }else{
        self.btnsView.hidden = YES;
        self.btnsViewH.constant = 0;
    }
    
    [self countDown];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)countDown {
    WholesaleOrderListCountDown *countDown = self.item.countDown;
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
            if ([self.delegate respondsToSelector:@selector(wholesaleOrderListCell:actionType:value:)]) {
                [self.delegate wholesaleOrderListCell:self actionType:WholesaleOrderListCellActionTypeCountDownOver value:_item];
            }
        }
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

#pragma mark - WholesaleOrderListCellBtnsViewDelegate

- (void)wholesaleOrderListCellBtnsView:(WholesaleOrderListCellBtnsView *)view actionBtn:(UIButton *)btn value:(id)value {
    if ([self.delegate respondsToSelector:@selector(wholesaleOrderListCell:actionType:value:)]) {
        [self.delegate wholesaleOrderListCell:self actionType:(WholesaleOrderListCellActionType)btn.tag value:_item];
    }
}

@end
