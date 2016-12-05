//
//  ProductOrderFreeListCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListCell.h"
#import "ProductOrderFreeListCellBtnsView.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface ProductOrderFreeListCell ()<ProductOrderFreeListCellBtnsViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *storeNameL;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusNameL;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *realPriceL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *remarkL;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet UIImageView *countDownIcon;
@property (weak, nonatomic) IBOutlet ProductOrderFreeListCellBtnsView *btnsView;
@end

@implementation ProductOrderFreeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _storeBtn.tag = ProductOrderFreeListCellActionTypeStore;
    _imageIcon.layer.cornerRadius = 4;
    _imageIcon.layer.masksToBounds = YES;
    _imageIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _imageIcon.layer.borderWidth = LINE_H;
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
    
    _btnsView.delegate = self;
}

- (void)setItem:(ProductOrderFreeListItem *)item {
    _item = item;
    _storeNameL.text = _item.storeInfo.storeName;
    _statusNameL.text = _item.productStatusStr;
    [_imageIcon sd_setImageWithURL:[NSURL URLWithString:_item.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
//    _remarkL.text = _item.reservationRemark;
    _timeL.text = _item.rowCreateTime;
    [self countDown];
//    _realPriceL.text = [NSString stringWithFormat:@"¥%@",_item.payPrice];
//    _btnsView.btnsAry = _item.btns;
}

- (void)countDown {
    NSString *str = _item.countDownValueString;
    if ([str isNotNull]) {
        _countDownIcon.hidden = NO;
        _countDownL.hidden = NO;
        _countDownL.text = str;
    }else{
        _countDownIcon.hidden = YES;
        _countDownL.hidden = YES;
    }
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeListCell:actionType:value:)]) {
        [self.delegate productOrderFreeListCell:self actionType:(ProductOrderFreeListCellActionType)sender.tag value:_item];
    }
}


#pragma mark - ProductOrderFreeListCellBtnsViewDelegate

- (void)productOrderListFreeCellBtnsView:(ProductOrderFreeListCellBtnsView *)view actionBtn:(UIButton *)btn value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeListCell:actionType:value:)]) {
        [self.delegate productOrderFreeListCell:self actionType:(ProductOrderFreeListCellActionType)btn.tag value:_item];
    }
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

@end
