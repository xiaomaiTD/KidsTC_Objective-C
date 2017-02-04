//
//  FlashServiceOrderDetailServiceInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderDetailServiceInfoCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface FlashServiceOrderDetailServiceInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *serveDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *failImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation FlashServiceOrderDetailServiceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    self.iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.iconImageView.layer.borderWidth = LINE_H;
    self.orderStatusDescLabel.textColor = COLOR_PINK_FLASH;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(FlashServiceOrderDetailData *)data{
    [super setData:data];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    
    self.failImageView.hidden = data.isFlashSuccess;
    
    NSMutableAttributedString *mutableAttStr = [[NSMutableAttributedString alloc]init];
    if ([data.productName isNotNull]) {
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
        NSAttributedString *nameAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",data.productName] attributes:att];
        [mutableAttStr appendAttributedString:nameAttStr];
    }
    if ([data.useValidTimeDesc isNotNull]) {
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
    self.orderStatusDescLabel.text = [data.orderStatusDesc isNotNull]?data.orderStatusDesc:@"";
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(flashServiceOrderDetailBaseCell:actionType:)]) {
        [self.delegate flashServiceOrderDetailBaseCell:self actionType:FlashServiceOrderDetailBaseCellActionTypeService];
    }
}

@end
