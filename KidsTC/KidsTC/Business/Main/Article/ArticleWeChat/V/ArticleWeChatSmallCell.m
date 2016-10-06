//
//  ArticleWeChatSmallCell.m
//  KidsTC
//
//  Created by zhanping on 7/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleWeChatSmallCell.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"
@interface ArticleWeChatSmallCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ArticleWeChatSmallCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.iconImageView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    self.iconImageView.layer.borderWidth = LINE_H;
}

- (void)setItem:(ArticleWeChatItem *)item{
    _item = item;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.titleLabel.text = [NSString stringWithFormat:@" %@",item.title];
}

@end
