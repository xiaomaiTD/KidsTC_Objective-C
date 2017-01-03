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

@interface ProductOrderFreeListCell ()
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
@end

@implementation ProductOrderFreeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _storeBtn.tag = ProductOrderFreeListBaseCellActionTypeStore;
    _imageIcon.layer.cornerRadius = 4;
    _imageIcon.layer.masksToBounds = YES;
    _imageIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _imageIcon.layer.borderWidth = LINE_H;
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setItem:(ProductOrderFreeListItem *)item {
    [super setItem:item];
    
    
    ProductOrderFreeListStore *storeInfo = self.item.storeInfo;
    
    self.storeNameL.text = storeInfo.storeName;
    self.statusNameL.text = self.item.productStatusStr;
    self.addressL.text = storeInfo.address;
    NSString *distance = [storeInfo.distance isNotNull]?[NSString stringWithFormat:@"距离:%@",storeInfo.distance]:nil;
    self.distanceL.text = distance;
    
    self.productNameL.text = self.item.productName;
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:self.item.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.remarkL.text = self.item.onlineBespeak.advanceDayDesc;
    self.timeL.text = self.item.startTimeStr;
    self.priceL.text = self.item.freeTypeStr;
    
    [self countDown];
    self.numL.text = self.item.joinCount;
    
    switch (self.item.placeType) {
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
            if ([self.delegate respondsToSelector:@selector(productOrderFreeListBaseCell:actionType:value:)]) {
                [self.delegate productOrderFreeListBaseCell:self actionType:ProductOrderFreeListBaseCellActionTypeCountDownOver value:self.item];
            }
        }
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

- (IBAction)action:(UIButton *)sender {
    if (self.item.placeType != PlaceTypeStore) return;
    if ([self.delegate respondsToSelector:@selector(productOrderFreeListBaseCell:actionType:value:)]) {
        [self.delegate productOrderFreeListBaseCell:self actionType:(ProductOrderFreeListBaseCellActionType)sender.tag value:self.item];
    }
}

@end
