//
//  ArticleHomeBannerCollectionViewTwoCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeBannerCollectionViewTwoCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface ArticleHomeBannerCollectionViewTwoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ArticleHomeBannerCollectionViewTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.imageView.layer.borderWidth = LINE_H;
//    self.imageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

- (void)setImgUrl:(NSString *)imgUrl {
    [super setImgUrl:imgUrl];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
}

@end
