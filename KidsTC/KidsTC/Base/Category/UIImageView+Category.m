//
//  UIImageView+Category.m
//  KidsTC
//
//  Created by zhanping on 7/27/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UIImageView+Category.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Category)
- (void)loadImageUrlStr:(NSString *)urlStr radius:(CGFloat)radius placeholderImage:(UIImage *)placeholderImage {
    
    if (!placeholderImage) {
        placeholderImage = PLACEHOLDERIMAGE_BIG;
    }
    
    //这里传CGFLOAT_MIN，就是默认以图片宽度的一半为圆角
    if (radius == CGFLOAT_MIN) {
        radius = self.frame.size.width/2.0;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    
    if (radius != 0.0) {
        //头像需要手动缓存处理成圆角的图片
        NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
        if (cacheImage) {
            self.image = cacheImage;
        }else {
            [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    UIImage *radiusImage = [UIImage circleImageWithImage:image borderWidth:4 borderColor:[UIColor colorWithWhite:1 alpha:0.5]];
                    self.image = radiusImage;
                    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlStr];
                    //清除原有非圆角图片缓存
                    [[SDImageCache sharedImageCache] removeImageForKey:urlStr];
                }
            }];
        }
    }else {
        [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:nil];
    }
}
@end
