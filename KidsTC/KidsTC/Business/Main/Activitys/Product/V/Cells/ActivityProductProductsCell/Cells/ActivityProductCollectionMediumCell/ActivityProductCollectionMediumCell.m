//
//  ActivityProductCollectionMediumCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ActivityProductCollectionMediumCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface ActivityProductCollectionMediumCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *infoContentView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@end

@implementation ActivityProductCollectionMediumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.buyBtn.layer.cornerRadius = 2;
    self.buyBtn.layer.masksToBounds = YES;
}

- (void)setItem:(ActivityProductItem *)item {
    [super setItem:item];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.productImage] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = item.productName;
    self.tipL.text = item.promotionText;
    self.priceL.text = item.priceDesc;
    [self.buyBtn setTitle:item.btnName forState:UIControlStateNormal];
}

@end
