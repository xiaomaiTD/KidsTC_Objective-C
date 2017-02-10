//
//  RadishOrderDetailProductCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailProductCell.h"
#import "UIImageView+WebCache.h"

@interface RadishOrderDetailProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *radishCountL;
@end

@implementation RadishOrderDetailProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setData:(RadishOrderDetailData *)data {
    [super setData:data];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:data.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = data.name;
    self.numL.text = [NSString stringWithFormat:@"数量：%zd",data.count];
    self.priceL.text = [NSString stringWithFormat:@"+%@元",data.price];
    self.radishCountL.text = [NSString stringWithFormat:@"%@根",data.radishNum];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(radishOrderDetailBaseCell:actionType:value:)]) {
        [self.delegate radishOrderDetailBaseCell:self actionType:RadishOrderDetailBaseCellActionTypeSegue value:self.data.productSegueModel];
    }
}

@end
