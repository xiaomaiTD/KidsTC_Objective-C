//
//  ProductDetailCommentCellCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailCommentCellCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface ProductDetailCommentCellCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ProductDetailCommentCellCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.layer.cornerRadius = 4;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = LINE_H;
    self.imageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
}

@end
