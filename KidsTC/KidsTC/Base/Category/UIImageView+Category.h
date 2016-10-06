//
//  UIImageView+Category.h
//  KidsTC
//
//  Created by zhanping on 7/27/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Category)
- (void)loadImageUrlStr:(NSString *)urlStr radius:(CGFloat)radius placeholderImage:(UIImage *)placeholderImage;
@end
