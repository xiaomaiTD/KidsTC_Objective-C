//
//  ArticleUserCenterCommentCollectionViewCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleUserCenterCommentCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface ArticleUserCenterCommentCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ArticleUserCenterCommentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imageView.layer.cornerRadius = 8;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _imageView.layer.borderWidth = LINE_H;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
}

@end
