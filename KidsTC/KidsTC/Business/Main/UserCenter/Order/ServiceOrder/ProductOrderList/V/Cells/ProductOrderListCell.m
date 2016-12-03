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

@interface ProductOrderListCell ()
@property (weak, nonatomic) IBOutlet UILabel *storeNameL;
@property (weak, nonatomic) IBOutlet UILabel *statusNameL;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *realPriceL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *remarkL;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet UIImageView *countDownIcon;
@property (weak, nonatomic) IBOutlet ProductOrderListCellBtnsView *btnsView;
@end

@implementation ProductOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _imageIcon.layer.cornerRadius = 4;
    _imageIcon.layer.masksToBounds = YES;
    _imageIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _imageIcon.layer.borderWidth = LINE_H;
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kProductOrderListCountDownNoti object:nil];
}

- (void)setItem:(ProductOrderListItem *)item {
    _item = item;
    _storeNameL.text = _item.storeName;
    _statusNameL.text = _item.statusName;
    [_imageIcon sd_setImageWithURL:[NSURL URLWithString:_item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    _remarkL.text = _item.reservationRemark;
    _timeL.text = _item.createTime;
    [self countDown];
    _realPriceL.text = [NSString stringWithFormat:@"¥%@",_item.payPrice];
    _btnsView.btnsAry = _item.btns;
}

- (void)countDown {
    NSString *str = _item.countDown.countDownValueString;
    if ([str isNotNull]) {
        _countDownIcon.hidden = NO;
        _countDownL.hidden = NO;
        _countDownL.text = str;
    }else{
        _countDownIcon.hidden = YES;
        _countDownL.hidden = YES;
    }
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kProductOrderListCountDownNoti object:nil];
}

@end
