//
//  ProductOrderTicketDetailProductCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailProductCell.h"
#import "UIImageView+WebCache.h"

@interface ProductOrderTicketDetailProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *theatherL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation ProductOrderTicketDetailProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setData:(ProductOrderTicketDetailData *)data {
    [super setData:data];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:data.img] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = data.serveName;
    self.theatherL.text = [NSString stringWithFormat:@"场馆：%@",data.theater];
    self.tipL.text = [NSString stringWithFormat:@"%@ / %@ / %@",data.city,data.kind,data.ticketTime];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productOrderTicketDetailBaseCell:actionType:value:)]) {
        [self.delegate productOrderTicketDetailBaseCell:self actionType:ProductOrderTicketDetailBaseCellActionTypeSegue value:self.data.productSegueModel];
    }
}
@end
