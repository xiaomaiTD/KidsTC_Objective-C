//
//  ArticleHomeBottomView.m
//  KidsTC
//
//  Created by zhanping on 9/2/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeBottomView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface ArticleHomeBottomView ()
@property (weak, nonatomic) IBOutlet UIImageView *authorHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *readImageView;
@property (weak, nonatomic) IBOutlet UILabel *readNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeNumLabel;
@end

@implementation ArticleHomeBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
    CALayer *authorHeaderLayer = self.authorHeaderImageView.layer;
    authorHeaderLayer.cornerRadius = 10;
    authorHeaderLayer.masksToBounds = YES;
//    authorHeaderLayer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    authorHeaderLayer.borderWidth = LINE_H;
}

- (void)setItem:(ArticleHomeItem *)item {
    _item = item;
    
    [self.authorHeaderImageView sd_setImageWithURL:[NSURL URLWithString:item.authorImgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.authorNameLabel.text = item.authorName;
    self.readNumLabel.text = [NSString stringWithFormat:@"%zd",item.readNum];
    self.likeNumLabel.text = [NSString stringWithFormat:@"%zd",item.likeNum];
    
    NSString *likeImgName = item.isLike?@"icon_news_like":@"icon_news_like_nor";
    self.likeImageView.image = [UIImage imageNamed:likeImgName];
}

@end
