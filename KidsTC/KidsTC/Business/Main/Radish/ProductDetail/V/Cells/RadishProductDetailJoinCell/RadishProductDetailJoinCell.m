//
//  RadishProductDetailJoinCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailJoinCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface RadishProductDetailJoinCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UIView *iconsView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *icons;
@property (weak, nonatomic) IBOutlet UILabel *numL;

@end

@implementation RadishProductDetailJoinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    CGFloat radius = CGRectGetWidth(self.numL.bounds) * 0.5;
    
    self.numL.layer.cornerRadius = radius;
    self.numL.layer.masksToBounds = YES;
    self.numL.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.numL.layer.borderWidth = LINE_H;
    [self.icons enumerateObjectsUsingBlock:^(UIImageView  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.cornerRadius = radius;
        obj.layer.masksToBounds = YES;
        obj.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        obj.layer.borderWidth = LINE_H;
    }];
    self.tipL.textColor = [UIColor colorFromHexString:@"555555"];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(RadishProductDetailData *)data {
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
    if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
        [self.delegate radishProductDetailBaseCell:self actionType:RadishProductDetailBaseCellActionTypeMoreComment value:self.data];
    }
}

@end
