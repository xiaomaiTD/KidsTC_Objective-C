//
//  ProductOrderNormalDetailProductCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailProductCell.h"
#import "UIImageView+WebCache.h"

@interface ProductOrderNormalDetailProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@end

@implementation ProductOrderNormalDetailProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:data.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = data.name;
    self.numL.text = [NSString stringWithFormat:@"数量：%zd",data.count];
    self.priceL.text = [NSString stringWithFormat:@"¥%@",data.price];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productOrderNormalDetailBaseCell:actionType:value:)]) {
        [self.delegate productOrderNormalDetailBaseCell:self actionType:ProductOrderNormalDetailBaseCellActionTypeSegue value:self.data.productSegueModel];
    }
}
@end
