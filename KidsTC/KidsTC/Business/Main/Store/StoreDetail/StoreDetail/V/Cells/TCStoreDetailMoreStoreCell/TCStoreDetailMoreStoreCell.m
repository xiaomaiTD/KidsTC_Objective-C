//
//  TCStoreDetailMoreStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailMoreStoreCell.h"
#import "FiveStarsView.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface TCStoreDetailMoreStoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *pricePreL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *priceSubL;

@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation TCStoreDetailMoreStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.HLineH.constant = LINE_H;
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    NSArray<TCStoreDetailNearbyStore *> *nearStores = self.data.nearbyData.nearStores;
    if (_index>=nearStores.count) return;
    TCStoreDetailNearbyStore *store = nearStores[_index];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:store.storeImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = store.storeName;
    self.starsView.starNumber = store.level;
    self.priceL.text = store.averagePrice;
    self.distanceL.text = [NSString stringWithFormat:@"距离%@",store.distanceStr];
}

- (IBAction)action:(UIButton *)sender {
    NSArray<TCStoreDetailNearbyStore *> *nearStores = self.data.nearbyData.nearStores;
    if (_index>=nearStores.count) return;
    TCStoreDetailNearbyStore *store = nearStores[_index];
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypeSegue value:store.segueModel];
    }
}
@end
