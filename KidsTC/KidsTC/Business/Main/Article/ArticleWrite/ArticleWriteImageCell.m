//
//  ArticleWriteImageCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleWriteImageCell.h"

@interface ArticleWriteImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintHeight;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation ArticleWriteImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _iconImageView.layer.borderWidth = LINE_H;
}

- (void)setModel:(ArticleWriteModel *)model {
    [super setModel:model];
    UIImage *image = model.image;
    _iconImageView.image = image;
    _deleteBtn.hidden = !model.canEdit;
    CGFloat scale = image.size.height/image.size.width;
    _iconConstraintHeight.constant = (SCREEN_WIDTH-24)*scale;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(articleWriteBaseCell:actionType:value:)]) {
        [self.delegate articleWriteBaseCell:self actionType:ArticleWriteBaseCellActionTypeDeletContentImage value:nil];
    }
}

@end
