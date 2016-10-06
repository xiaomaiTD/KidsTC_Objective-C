//
//  ArticleWriteCoverCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleWriteCoverCell.h"

@interface ArticleWriteCoverCell ()
@property (weak, nonatomic) IBOutlet UIView *placeHolderView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end

@implementation ArticleWriteCoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _coverImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _coverImageView.layer.borderWidth = LINE_H;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCover)];
    [self addGestureRecognizer:tapGR];
}

- (void)setModel:(ArticleWriteModel *)model {
    [super setModel:model];
    self.placeHolderView.hidden = (model.image!=nil);
    self.coverImageView.hidden = model.image==nil;
    if (!self.coverImageView.hidden) {
        self.coverImageView.image = model.image;
    }
}

- (void)selectCover {
    if ([self.delegate respondsToSelector:@selector(articleWriteBaseCell:actionType:value:)]) {
        [self.delegate articleWriteBaseCell:self actionType:ArticleWriteBaseCellActionTypeSelectCover value:nil];
    }
}

@end
