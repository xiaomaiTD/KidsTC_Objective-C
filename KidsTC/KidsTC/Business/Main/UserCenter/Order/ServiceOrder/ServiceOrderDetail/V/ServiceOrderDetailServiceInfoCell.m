//
//  ServiceOrderDetailServiceInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailServiceInfoCell.h"
#import "UIImageView+WebCache.h"

@interface ServiceOrderDetailServiceInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *serveDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation ServiceOrderDetailServiceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    self.iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.iconImageView.layer.borderWidth = LINE_H;
    self.priceLabel.textColor = COLOR_PINK;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(ServiceOrderDetailData *)data{
    [super setData:data];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];

    NSMutableAttributedString *mutableAttStr = [[NSMutableAttributedString alloc]init];
    if (data.name.length>0) {
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
        NSAttributedString *nameAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",data.name] attributes:att];
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
        paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
        [mutableAttStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, mutableAttStr.length)];
    }
    
    self.serveDescLabel.attributedText = mutableAttStr;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%0.1f",data.price];
    self.countLabel.text = data.count>0?[NSString stringWithFormat:@"x%zd",data.count]:@"";
    self.payTypeLabel.text = data.paytypename.length>0?[NSString stringWithFormat:@"(%@)",data.paytypename]:@"";
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(serviceOrderDetailBaseCell:actionType:)]) {
        [self.delegate serviceOrderDetailBaseCell:self actionType:ServiceOrderDetailBaseCellActionTypeServiceDetail];
    }
}


@end
