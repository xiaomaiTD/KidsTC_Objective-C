//
//  ProductDetailBannerCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailBannerCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface ProductDetailBannerCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ProductDetailBannerCollectionViewCell

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
}

@end
