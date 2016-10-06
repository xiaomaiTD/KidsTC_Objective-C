//
//  ArticleUserCenterToolBarItem.m
//  KidsTC
//
//  Created by zhanping on 2016/9/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleUserCenterToolBarItem.h"

@interface ArticleUserCenterToolBarItem ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *line;
@end

@implementation ArticleUserCenterToolBarItem

- (void)awakeFromNib {
    [super awakeFromNib];
    _line.backgroundColor = COLOR_PINK;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [self addGestureRecognizer:tapGR];
}

- (void)action:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(articleUserCenterToolBarItem:actionType:)]) {
        [self.delegate articleUserCenterToolBarItem:self actionType:_type];
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    _titleLabel.textColor = selected?COLOR_PINK:[UIColor darkGrayColor];
    _line.hidden = !selected;
    
    NSString *imageName = @"";
    switch (_type) {
        case ArticleUserCenterToolBarItemTypeArticle:
        {
            imageName = _selected?@"ArticleUserCenterArticleSel":@"ArticleUserCenterArticleNor";
        }
            break;
        default:
        {
            imageName = _selected?@"ArticleUserCenterCommentSel":@"ArticleUserCenterCommentNor";
        }
            break;
    }
    _imageView.image = [UIImage imageNamed:imageName];
}

@end
