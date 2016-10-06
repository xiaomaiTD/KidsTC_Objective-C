//
//  PosterViewCell.m
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "PosterViewCell.h"
#import "UIImage+GIF.h"
@interface PosterViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end

@implementation PosterViewCell

- (void)setItem:(PosterAdsItem *)item{
    _item = item;
    self.iconImageView.image = [UIImage sd_animatedGIFWithData:item.imageData];
}

@end
