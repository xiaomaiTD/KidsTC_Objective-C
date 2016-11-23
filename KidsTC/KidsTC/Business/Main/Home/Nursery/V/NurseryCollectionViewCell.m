//
//  NurseryCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NurseryCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface NurseryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation NurseryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
}

@end
