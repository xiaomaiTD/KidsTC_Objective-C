//
//  FlashServiceOrderDetailProgressCollectionViewCell.m
//  KidsTC
//
//  Created by zhanping on 8/18/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderDetailProgressCollectionViewCell.h"

@interface FlashServiceOrderDetailProgressCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation FlashServiceOrderDetailProgressCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setConfig:(FlashServiceOrderDetailPriceConfig *)config{
    _config = config;
    
    UIColor *priceLTextColor = [UIColor lightGrayColor];
    NSString *imageName = @"priceState-0";
    if (config.priceStatus == FlashBuyProductDetailPriceConfigCurrentAchieved) {
        priceLTextColor = COLOR_PINK_FLASH;
        imageName = @"priceState-1";
    }
    self.bgImageView.image = [UIImage imageNamed:imageName];
    self.priceLabel.textColor = priceLTextColor;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %0.0f",config.price];
    
    
    NSString *peopleNumString = [NSString stringWithFormat:@"%zd人闪购价\n%@",config.peopleNum,config.priceStatusName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.paragraphSpacing = 4;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    NSAttributedString *peopleNumAttributedString = [[NSAttributedString alloc]initWithString:peopleNumString attributes:attributes];
    self.statusLabel.attributedText = peopleNumAttributedString;
}

@end
