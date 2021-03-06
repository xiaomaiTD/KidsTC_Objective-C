//
//  CollectProductReduceCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductReduceCell.h"
#import "Colours.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"

@interface CollectProductReduceCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerIcon;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerIconH;
@property (weak, nonatomic) IBOutlet UILabel *reduceL;
@property (weak, nonatomic) IBOutlet UIImageView *reduceIcon;
@end

@implementation CollectProductReduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    
    self.priceL.textColor = COLOR_PINK;
    self.icon.layer.cornerRadius = CGRectGetWidth(self.icon.bounds) * 0.5;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderWidth = 1;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    self.contentView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    self.nameL.textColor = [UIColor colorFromHexString:@"333333"];
    self.addressL.textColor = [UIColor colorFromHexString:@"999999"];
    self.statusL.textColor = [UIColor colorFromHexString:@"999999"];
    self.priceL.textColor = [UIColor colorFromHexString:@"F36863"];
    self.reduceL.textColor = [UIColor colorFromHexString:@"7EBCF2"];
}

- (void)setItem:(CollectProductItem *)item {
    _item = item;
    
    [self.bannerIcon sd_setImageWithURL:[NSURL URLWithString:_item.img] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.icon.hidden = ![_item.supplierIconImg isNotNull];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_item.supplierIconImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = _item.name;
    self.priceL.text = [NSString stringWithFormat:@"%@",_item.price];
    self.addressL.text = [NSString stringWithFormat:@"%@ %@",_item.address,_item.distanceDesc];
    self.statusL.text = [NSString stringWithFormat:@"%@",_item.endTimeDesc];
    
    BOOL reduce = [_item.markdownPrice floatValue] > 0;
    self.reduceIcon.hidden = !reduce;
    self.reduceL.hidden = !reduce;
    self.reduceL.text = [NSString stringWithFormat:@"下降了¥%@",_item.markdownPrice];
    
    self.bannerIconH.constant = CGRectGetWidth(self.bannerIcon.frame) * _item.imgRatio;
    //[self layoutIfNeeded];
}

- (IBAction)action:(UIButton *)sender {
    if (self.deleteAction) {
        self.deleteAction();
    }
}

@end
