//
//  ArticleHomeBaseCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeBaseCell.h"

@interface ArticleHomeBaseCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation ArticleHomeBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    _HLineConstraintHeight.constant = LINE_H;
    
    UIView *selectedBackgroundView = [[UIView alloc]init];
    selectedBackgroundView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    self.selectedBackgroundView = selectedBackgroundView;
    
    if (!_deleteBtn) {
        CGFloat btnSize = 20;
        _deleteBtn = [UIButton new];
        _deleteBtn.hidden = YES;
        _deleteBtn.frame = CGRectMake(SCREEN_WIDTH-btnSize-7, 8, btnSize, btnSize);
        [_deleteBtn setImage:[UIImage imageNamed:@"icon_close_pink_round"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteNewsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteBtn];
    }
}

- (void)deleteNewsAction:(UIButton *)btn {
    if (self.deleteNewsBlock) {
        self.deleteNewsBlock(self.item);
    }
}

@end
