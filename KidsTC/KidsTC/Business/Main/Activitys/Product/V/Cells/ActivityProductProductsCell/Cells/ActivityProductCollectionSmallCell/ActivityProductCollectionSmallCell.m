//
//  ActivityProductCollectionSmallCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductCollectionSmallCell.h"
#import "UIImageView+WebCache.h"
@interface ActivityProductCollectionSmallCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@end

@implementation ActivityProductCollectionSmallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    
    self.buyBtn.layer.cornerRadius = 2;
    self.buyBtn.layer.masksToBounds = YES;
}
- (void)setItem:(ActivityProductItem *)item {
    [super setItem:item];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.productImage] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.nameL.text = item.productName;
    self.tipL.text = item.promotionText;
    self.priceL.text = item.priceDesc;
    [self.buyBtn setTitle:item.btnName forState:UIControlStateNormal];
}
@end
