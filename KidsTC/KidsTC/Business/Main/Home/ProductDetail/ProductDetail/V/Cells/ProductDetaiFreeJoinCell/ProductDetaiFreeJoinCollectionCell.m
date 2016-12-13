//
//  ProductDetaiFreeJoinCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetaiFreeJoinCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface ProductDetaiFreeJoinCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@end

@implementation ProductDetaiFreeJoinCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self layoutIfNeeded];
    if ([_imageUrl hasPrefix:@"http"]) {
        self.icon.layer.borderColor = [UIColor whiteColor].CGColor;
        self.icon.layer.borderWidth = 2;
        self.icon.layer.cornerRadius = CGRectGetWidth(self.bounds) * 0.5;
        self.icon.layer.masksToBounds = YES;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    }else{
        self.icon.layer.borderColor = [UIColor clearColor].CGColor;
        self.icon.image = [UIImage imageNamed:_imageUrl];
    }
}

@end
