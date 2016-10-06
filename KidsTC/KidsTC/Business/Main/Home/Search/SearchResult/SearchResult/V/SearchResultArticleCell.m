//
//  SearchResultArticleCell.m
//  KidsTC
//
//  Created by zhanping on 7/7/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultArticleCell.h"
#import "UIImageView+WebCache.h"
#import "Macro.h"
@interface SearchResultArticleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

@end

@implementation SearchResultArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *selectedBackgroundView = [[UIView alloc]init];
    selectedBackgroundView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    self.selectedBackgroundView = selectedBackgroundView;
    self.articleImageView.layer.cornerRadius = 4;
    self.articleImageView.layer.masksToBounds = YES;
    self.articleImageView.layer.borderWidth = LINE_H;
    self.articleImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

- (void)setItem:(SearchResultArticleItem *)item{
    _item = item;
    
    [self.articleImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.titleLabel.text = item.title;
    self.authorNameLabel.text = item.authorName;
    self.viewCountLabel.text = [NSString stringWithFormat:@"%zd",item.viewCount];
    self.commentCountLabel.text = [NSString stringWithFormat:@"%zd",item.commentCount];
}

@end
