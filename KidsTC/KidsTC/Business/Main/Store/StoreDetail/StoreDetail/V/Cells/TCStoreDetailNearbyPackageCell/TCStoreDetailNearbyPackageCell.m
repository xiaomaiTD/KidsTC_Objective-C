//
//  TCStoreDetailNearbyPackageCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailNearbyPackageCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface TCStoreDetailNearbyPackageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property (weak, nonatomic) IBOutlet UIView *categoryBGView;
@property (weak, nonatomic) IBOutlet UILabel *categoryL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoryBGViewLeading;

@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet UILabel *saleNumL;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation TCStoreDetailNearbyPackageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    self.categoryBGView.layer.borderColor = [UIColor colorFromHexString:@"FE80A5"].CGColor;
    self.categoryBGView.layer.borderWidth = 1;
    
    self.HLineH.constant = LINE_H;
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    NSArray<TCStoreDetailNearbyProduct *> *nearProducts = data.nearbyData.nearProducts;
    if (_index>=nearProducts.count) return;
    TCStoreDetailNearbyProduct *product = nearProducts[_index];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:product.imgurl] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = product.name;
    self.priceL.text = product.price;
    self.categoryBGView.hidden = ![product.categoryName isNotNull];
    self.categoryL.text = product.categoryName;
    self.categoryBGViewLeading.constant = self.categoryBGView.hidden?0:8;
    self.distanceL.text = [NSString stringWithFormat:@"距离%@",product.distance];
    self.saleNumL.text = [NSString stringWithFormat:@"已售%@",product.num];
}

- (IBAction)action:(UIButton *)sender {
    NSArray<TCStoreDetailNearbyProduct *> *nearProducts = self.data.nearbyData.nearProducts;
    if (_index>=nearProducts.count) return;
    TCStoreDetailNearbyProduct *product = nearProducts[_index];
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypeSegue value:product.segueModel];
    }
}

@end
