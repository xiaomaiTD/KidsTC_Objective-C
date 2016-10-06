//
//  ArticleUserCenterToolBar.m
//  KidsTC
//
//  Created by zhanping on 2016/9/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleUserCenterToolBar.h"

int const kArticleUserCenterToolBarHeight = 40;

@interface ArticleUserCenterToolBar ()<ArticleUserCenterToolBarItemDelegate>
@property (weak, nonatomic) IBOutlet ArticleUserCenterToolBarItem *articleBarItem;
@property (weak, nonatomic) IBOutlet ArticleUserCenterToolBarItem *commentBarItem;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation ArticleUserCenterToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _articleBarItem.type = ArticleUserCenterToolBarItemTypeArticle;
    _commentBarItem.type = ArticleUserCenterToolBarItemTypeComment;
    
    _articleBarItem.delegate = self;
    _commentBarItem.delegate = self;
    
    _VLineConstraintHeight.constant = LINE_H;
    _HLineConstraintHeight.constant = LINE_H;

}

- (void)beginRefreshing {
    [self articleUserCenterToolBarItem:_articleBarItem actionType:_articleBarItem.type];
}

#pragma mark - ArticleUserCenterToolBarItemDelegate

- (void)articleUserCenterToolBarItem:(ArticleUserCenterToolBarItem *)item actionType:(ArticleUserCenterToolBarItemType)type {
    _articleBarItem.selected = _articleBarItem==item;
    _commentBarItem.selected = _commentBarItem==item;
    
    if ([self.delegate respondsToSelector:@selector(articleUserCenterToolBar:currentType:)]) {
        [self.delegate articleUserCenterToolBar:self currentType:type];
    }
}


@end
