//
//  ArticleHomeClassView.m
//  KidsTC
//
//  Created by zhanping on 9/5/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeClassView.h"
#import "UIImageView+WebCache.h"
#import "ArticleHomeClassButton.h"


@interface ArticleHomeClassView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<ArticleHomeClassButton *> *btns;
@property (nonatomic, strong) ArticleHomeClassButton *selectBtn;
@end

@implementation ArticleHomeClassView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.btns = [NSMutableArray array];
}

- (void)setClazz:(ArticleHomeClass *)clazz {
    _clazz = clazz;
    self.backgroundColor = clazz.bgColor;
    
    [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btns removeAllObjects];
    
    __block UIButton *lastBtn = nil;
    CGFloat btn_s = CGRectGetHeight(self.frame);
    [_clazz.classes enumerateObjectsUsingBlock:^(ArticleHomeClassItem *obj, NSUInteger idx, BOOL *stop) {
        ArticleHomeClassButton *btn = [ArticleHomeClassButton new];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        btn.item = obj;
        btn.frame = CGRectMake(btn_s * idx, 0, btn_s, btn_s);
        [self.scrollView addSubview:btn];
        [self.btns addObject:btn];
        lastBtn = btn;
    }];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame), btn_s);
    
    if (self.btns.count>0) {
        ArticleHomeClassButton *btn = self.btns.firstObject;
        btn.selected = YES;
        self.selectBtn = btn;
    }
}


- (void)action:(ArticleHomeClassButton *)btn {
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
    if ([self.delegate respondsToSelector:@selector(articleHomeClassView:didSelectItem:)]) {
        [self.delegate articleHomeClassView:self didSelectItem:btn.item];
    }
}


@end
