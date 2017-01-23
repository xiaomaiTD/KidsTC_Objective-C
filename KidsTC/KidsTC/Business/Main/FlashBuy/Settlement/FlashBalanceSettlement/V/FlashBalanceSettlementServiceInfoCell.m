//
//  FlashBalanceSettlementServiceInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashBalanceSettlementServiceInfoCell.h"
#import "UIImageView+WebCache.h"

@interface FlashBalanceSettlementServiceInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *serveDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation FlashBalanceSettlementServiceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.iconImageView.layer.borderWidth = LINE_H;
    self.priceLabel.textColor = COLOR_PINK;
}
- (void)setData:(FlashSettlementData *)data{
    [super setData:data];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    
    NSMutableAttributedString *mutableAttStr = [[NSMutableAttributedString alloc]init];
    if (data.productName.length>0) {
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
        NSAttributedString *nameAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",data.productName] attributes:att];
        [mutableAttStr appendAttributedString:nameAttStr];
    }
    if (data.useValidTimeDesc.length>0) {
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        NSAttributedString *timeAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@使用有效期：%@",mutableAttStr.length>0?@"\n":@"",data.useValidTimeDesc] attributes:att];
        [mutableAttStr appendAttributedString:timeAttStr];
    }
    if (mutableAttStr.length>0) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.lineSpacing = 8;
        [mutableAttStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, mutableAttStr.length)];
    }
    
    self.serveDescLabel.attributedText = mutableAttStr;
    self.priceLabel.text = [NSString stringWithFormat:@"尾款：¥%0.1f",data.price];
}

@end
