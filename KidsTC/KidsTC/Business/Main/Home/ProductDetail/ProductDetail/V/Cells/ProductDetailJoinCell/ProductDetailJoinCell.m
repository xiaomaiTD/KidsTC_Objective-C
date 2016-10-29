//
//  ProductDetailJoinCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailJoinCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface ProductDetailJoinCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UIView *iconsView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *icons;
@property (weak, nonatomic) IBOutlet UILabel *numL;

@end

@implementation ProductDetailJoinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.numL.layer.cornerRadius = 25;
    self.numL.layer.masksToBounds = YES;
    self.numL.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.numL.layer.borderWidth = 1;
    [self.icons enumerateObjectsUsingBlock:^(UIImageView  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.cornerRadius = 25;
        obj.layer.masksToBounds = YES;
        obj.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        obj.layer.borderWidth = 1;
    }];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
    self.numL.text = [NSString stringWithFormat:@"%zd",data.comment.all];
    __block NSUInteger count = self.icons.count - data.comment.userHeadImgs.count;
    [self.icons enumerateObjectsUsingBlock:^(UIImageView  *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<count) {
            imageView.hidden = YES;
        }else{
            imageView.hidden = NO;
            NSString *imgUrl = data.comment.userHeadImgs[idx-count];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
        }
    }];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

@end
