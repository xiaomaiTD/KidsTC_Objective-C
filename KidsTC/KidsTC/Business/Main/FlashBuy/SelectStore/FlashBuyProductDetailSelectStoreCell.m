//
//  FlashBuyProductDetailSelectStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailSelectStoreCell.h"
#import "FiveStarsView.h"

@interface FlashBuyProductDetailSelectStoreCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation FlashBuyProductDetailSelectStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setStore:(FlashBuyProductDetailStore *)store {
    _store = store;
    self.nameL.text = store.storeName;
    self.starsView.starNumber = store.level;
    self.distanceL.text = store.distance;
    self.nameL.textColor = store.select?[UIColor colorFromHexString:@"ff8888"]:[UIColor colorFromHexString:@"222222"];
}

@end
