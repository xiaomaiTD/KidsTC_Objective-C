//
//  ProductOrderFreeDetailProductCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailProductCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface ProductOrderFreeDetailProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *ageL;
@property (weak, nonatomic) IBOutlet UIImageView *arrowL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@end

@implementation ProductOrderFreeDetailProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.statusL.layer.cornerRadius = 4;
    self.statusL.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}


- (void)setInfoData:(ProductOrderFreeDetailData *)infoData {
    [super setInfoData:infoData];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:infoData.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = infoData.productName;
    self.timeL.text = infoData.startTimeStr;
    self.ageL.text = infoData.ageStr;
    if ([infoData.productStatusStr isNotNull]) {
        self.statusL.text = infoData.productStatusStr;
        self.statusL.hidden = NO;
    }else{
        self.statusL.hidden = YES;
    }
}


- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeDetailInfoBaseCell:actionType:value:)]) {
        [self.delegate productOrderFreeDetailInfoBaseCell:self actionType:ProductOrderFreeDetailInfoBaseCellActionTypeSegue value:self.infoData.segueModel];
    }
}

@end
