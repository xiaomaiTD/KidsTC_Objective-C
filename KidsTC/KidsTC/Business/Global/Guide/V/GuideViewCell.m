//
//  GuideViewCell.m
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "GuideViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"

@implementation GuideViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(GuideDataItem *)item {
    _item = item;
    
//    UIImage *image = [UIImage imageNamed:item.imageName];
//    if (!image) {
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:item.imageName ofType:nil];
//        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
//        image = [UIImage sd_animatedGIFWithData:imageData];
//    }
    self.iconImageView.image = [UIImage sd_animatedGIFNamed:item.imageName];
}

@end
