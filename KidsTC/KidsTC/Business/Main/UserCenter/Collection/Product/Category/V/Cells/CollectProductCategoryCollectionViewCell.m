//
//  CollectProductCategoryCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductCategoryCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CollectProductCategoryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation CollectProductCategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
}

@end
