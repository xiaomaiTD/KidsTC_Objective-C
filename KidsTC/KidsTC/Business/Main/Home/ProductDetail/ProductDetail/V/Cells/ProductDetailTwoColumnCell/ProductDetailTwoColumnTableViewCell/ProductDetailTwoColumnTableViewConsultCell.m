//
//  ProductDetailTwoColumnTableViewConsultCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnTableViewConsultCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface ProductDetailTwoColumnTableViewConsultCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;

@end

@implementation ProductDetailTwoColumnTableViewConsultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImageView.layer.cornerRadius = 25;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.headImageView.layer.borderWidth = LINE_H;
    
}

- (void)setItem:(ProductDetailConsultItem *)item {
    [super setItem:item];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:item.headUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = item.name;
    self.nameL.textColor = item.isReply?COLOR_PINK:[UIColor darkGrayColor];
    self.contentL.text = item.content;
    self.timeL.text = item.time;
}


@end
