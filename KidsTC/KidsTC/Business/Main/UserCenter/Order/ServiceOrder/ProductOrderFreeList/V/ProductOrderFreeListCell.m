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
@property (weak, nonatomic) IBOutlet UIImageView *storeIcon;
@property (weak, nonatomic) IBOutlet UILabel *storeNameL;
@property (weak, nonatomic) IBOutlet UIImageView *storeArrowImg;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusNameL;
@property (weak, nonatomic) IBOutlet UIImageView *addressIcon;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *productNameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *remarkL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet UIImageView *countDownIcon;
@property (weak, nonatomic) IBOutlet ProductOrderFreeListCellBtnsView *btnsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsViewH;

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
    
    
    ProductOrderFreeListStore *storeInfo = _item.storeInfo;
    
    self.storeNameL.text = storeInfo.storeName;
    self.statusNameL.text = _item.productStatusStr;
    self.addressL.text = storeInfo.address;
    NSString *distance = [storeInfo.distance isNotNull]?[NSString stringWithFormat:@"距离:%@",storeInfo.distance]:nil;
    self.distanceL.text = distance;
    
    self.productNameL.text = _item.productName;
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:_item.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.remarkL.text = _item.onlineBespeak.advanceDayDesc;
    self.timeL.text = _item.startTimeStr;
    self.priceL.text = _item.freeTypeStr;
    
    [self countDown];
    self.numL.text = _item.joinCount;
    
    if (_item.btns.count>0) {
        self.btnsView.btnsAry = _item.btns;
        self.btnsView.hidden = NO;
        self.btnsViewH.constant = 46;
    }else{
        self.btnsView.hidden = YES;
        self.btnsViewH.constant = 0;
    }
    
    switch (_item.placeType) {
        case PlaceTypeStore:
        {
            self.storeIcon.hidden = NO;
            self.storeArrowImg.hidden = NO;
            self.storeNameL.hidden = NO;
            self.addressIcon.hidden = NO;
            self.addressL.hidden = NO;
            self.distanceL.hidden = NO;
        }
            break;
        case PlaceTypeNone:
        {
            self.storeIcon.hidden = YES;
            self.storeArrowImg.hidden = YES;
            self.storeNameL.hidden = YES;
            self.addressIcon.hidden = YES;
            self.addressL.hidden = YES;
            self.distanceL.hidden = YES;
            
        }
        default:
        {
            self.storeIcon.hidden = NO;
            self.storeArrowImg.hidden = YES;
            self.storeNameL.hidden = NO;
            self.addressIcon.hidden = NO;
            self.addressL.hidden = NO;
            self.distanceL.hidden = NO;
        }
            break;
    }
}

- (void)countDown {
    ProductOrderFreeListCountDown *countDown = self.item.countDown;
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
            if ([self.delegate respondsToSelector:@selector(productOrderFreeListCell:actionType:value:)]) {
                [self.delegate productOrderFreeListCell:self actionType:ProductOrderFreeListCellActionTypeCountDownOver value:_item];
            }
        }
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

- (IBAction)action:(UIButton *)sender {
    if (_item.placeType != PlaceTypeStore) return;
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

@end
