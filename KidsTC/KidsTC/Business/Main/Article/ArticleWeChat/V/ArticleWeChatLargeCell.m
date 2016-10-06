//
//  ArticleWeChatLargeCell.m
//  KidsTC
//
//  Created by zhanping on 7/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleWeChatLargeCell.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"
@interface ArticleWeChatLargeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation ArticleWeChatLargeCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.iconImageView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    self.iconImageView.layer.borderWidth = LINE_H;
    self.titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor *backgroundColor = self.titleLabel.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    self.titleLabel.backgroundColor = backgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    UIColor *backgroundColor = self.titleLabel.backgroundColor;
    [super setSelected:selected animated:animated];
    self.titleLabel.backgroundColor = backgroundColor;
}

- (void)setItem:(ArticleWeChatItem *)item{
    _item = item;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.titleLabel.text = [NSString stringWithFormat:@" %@",item.title];
}

@end
