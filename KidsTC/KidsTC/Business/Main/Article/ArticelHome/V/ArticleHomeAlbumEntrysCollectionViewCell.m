//
//  ArticleHomeAlbumEntrysCollectionViewCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeAlbumEntrysCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface ArticleHomeAlbumEntrysCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ArticleHomeAlbumEntrysCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    CALayer *layer      = self.imageView.layer;
//    layer.borderColor   = [UIColor groupTableViewBackgroundColor].CGColor;
//    layer.borderWidth   = LINE_H;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
}

@end
