//
//  ProductOrderFreeDetailProductCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailProductCell.h"
#import "UIImageView+WebCache.h"

@interface ProductOrderFreeDetailProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UIImageView *arrowL;
@end

@implementation ProductOrderFreeDetailProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
}


- (void)setInfoData:(ProductOrderFreeDetailData *)infoData {
    [super setInfoData:infoData];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:infoData.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = infoData.productName;
    self.timeL.text = infoData.startTimeStr;
    self.statusL.text = infoData.ageStr;
}

- (void)setLotteryData:(ProductOrderFreeDetailLotteryData *)lotteryData {
    [super setLotteryData:lotteryData];
}

@end
