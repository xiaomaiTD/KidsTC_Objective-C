//
//  ServiceSettlementServiceInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementServiceInfoCell.h"
#import "UIImageView+WebCache.h"

@interface ServiceSettlementServiceInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *serveDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ServiceSettlementServiceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.iconImageView.layer.borderWidth = LINE_H;
    self.priceLabel.textColor = COLOR_PINK;
}

- (void)setItem:(ServiceSettlementDataItem *)item{
    [super setItem:item];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    
    NSMutableAttributedString *mutableAttStr = [[NSMutableAttributedString alloc]init];
    if (item.serveName.length>0) {
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
        NSAttributedString *nameAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",item.serveName] attributes:att];
        [mutableAttStr appendAttributedString:nameAttStr];
    }
    if (item.useValidTimeDesc.length>0) {
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        NSAttributedString *timeAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n使用有效期：%@",item.useValidTimeDesc] attributes:att];
        [mutableAttStr appendAttributedString:timeAttStr];
    }
    if (mutableAttStr.length>0) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.lineSpacing = 8;
        [mutableAttStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, mutableAttStr.length)];
    }
    
    self.serveDescLabel.attributedText = mutableAttStr;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%0.1f",item.price];
    self.countLabel.text = item.count>0?[NSString stringWithFormat:@"x%zd",item.count]:@"";
}

@end
