//
//  CommentUtilsCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "CommentUtilsCollectionCell.h"

@interface CommentUtilsCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CommentUtilsCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.imageView.layer.borderWidth = LINE_H;
}

- (void)setImg:(UIImage *)img {
    _img = img;
    self.imageView.image = img;
}

@end
