//
//  FlashBuyProductDetailRuleCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailRuleCell.h"
#import "UIImageView+WebCache.h"

@interface FlashBuyProductDetailRuleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconH;
@end

@implementation FlashBuyProductDetailRuleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(FlashBuyProductDetailData *)data {
    [super setData:data];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:data.flowImg] placeholderImage:PLACEHOLDERIMAGE_BIG completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize imgSize = image.size;
        if (imgSize.width>0) {
            CGFloat ratio = imgSize.height/imgSize.width;
            self.iconH.constant = SCREEN_WIDTH*ratio;
        }
        [self layoutIfNeeded];
    }];
}

@end
