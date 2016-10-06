//
//  ArticleHomeBannerCollectionViewOneCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeBannerCollectionViewOneCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface ArticleHomeBannerCollectionViewOneCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ArticleHomeBannerCollectionViewOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setImgUrl:(NSString *)imgUrl {
    [super setImgUrl:imgUrl];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
}

@end
