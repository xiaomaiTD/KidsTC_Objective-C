//
//  ProductDetailTicketInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketInfoCell.h"
#import "UIImageView+WebCache.h"

@interface ProductDetailTicketInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *infoL;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *bgIcon;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *starBtn;
@end

@implementation ProductDetailTicketInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.priceL.textColor = COLOR_PINK;
    [self addCorner:self.likeBtn.layer];
    [self addCorner:self.starBtn.layer];
    self.likeBtn.tag = ProductDetailBaseCellActionTypeTicketLike;
    self.starBtn.tag = ProductDetailBaseCellActionTypeTicketStar;
}

- (void)addCorner:(CALayer *)layer {
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    layer.borderWidth = LINE_H;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:sender.tag value:nil];
    }
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.likeBtn.selected =  data.isFavor;
}

@end
