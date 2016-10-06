//
//  OrderBookingServiceInfoCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "OrderBookingServiceInfoCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface OrderBookingServiceInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *advanceDayLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation OrderBookingServiceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.productImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.productImageView.layer.borderWidth = LINE_H;
    self.HLineConstraintHeight.constant = LINE_H;
    self.advanceDayLabel.textColor = COLOR_PINK;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(OrderBookingData *)data {
    [super setData:data];
    
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:data.productInfo.productImage] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    _nameLabel.text = data.productInfo.productName;
    _ageLabel.text = [NSString stringWithFormat:@"适应年龄：%@",data.productInfo.ageGroupDesc];
    NSString *advanceDayDesc = data.productOnlineBespeakConfig.advanceDayDesc;
    _advanceDayLabel.text = [advanceDayDesc isNotNull]?advanceDayDesc:@"";
    
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(orderBookingBaseCell:actionType:value:)]) {
        [self.delegate orderBookingBaseCell:self actionType:OrderBookingBaseCellActionTypeServiceInfo value:nil];
    }
}

@end
