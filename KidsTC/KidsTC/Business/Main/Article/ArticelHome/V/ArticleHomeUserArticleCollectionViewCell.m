//
//  ArticleHomeUserArticleCollectionViewCell.m
//  KidsTC
//
//  Created by zhanping on 9/8/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeUserArticleCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface ArticleHomeUserArticleCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ArticleHomeUserArticleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
}

@end
