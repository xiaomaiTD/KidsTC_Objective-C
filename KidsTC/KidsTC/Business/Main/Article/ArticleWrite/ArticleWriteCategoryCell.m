//
//  ArticleWriteCategoryCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleWriteCategoryCell.h"
#import "ArticleHomeModel.h"
#import "UIButton+Category.h"

static int const kButtonHeight = 30;
static int const kButtonLRMargin = 12;

@interface ArticleWriteCategoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;
@property (nonatomic, strong) UIButton *selBtn;
@end

@implementation ArticleWriteCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.HLineConstraintHeight.constant = LINE_H;
    self.btns = [NSMutableArray array];
}

- (void)setClasses:(NSArray<ArticleHomeClassItem *> *)classes {
    [super setClasses:classes];
    
    [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btns removeAllObjects];
    
    [self.classes enumerateObjectsUsingBlock:^(ArticleHomeClassItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [self btnWithItem:obj tag:idx];
        [self.scrollView addSubview:btn];
        [self.btns addObject:btn];
        if (idx == self.selBtn.tag) [self action:btn];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btn_h = kButtonHeight;
    CGFloat btn_y = (CGRectGetHeight(self.frame) - btn_h) * 0.5;
    __block UIButton *lastBtn = nil;
    [self.btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat btn_x = CGRectGetMaxX(lastBtn.frame) + kButtonLRMargin;
        CGFloat btn_w = [obj.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:obj.titleLabel.font}].width + 24;
        lastBtn = obj;
        obj.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
    }];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame)+kButtonLRMargin, 54);
}

- (UIButton *)btnWithItem:(ArticleHomeClassItem *)item tag:(NSUInteger)tag {
    UIButton *btn = [UIButton new];
    btn.tag = tag;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:COLOR_PINK_FLASH forState:UIControlStateSelected];
    btn.layer.cornerRadius = kButtonHeight*0.5;
    btn.layer.masksToBounds = YES;
    [btn setTitle:item.className forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)action:(UIButton *)btn {
    self.selBtn.selected = NO;
    btn.selected = YES;
    self.selBtn = btn;
    if ([self.delegate respondsToSelector:@selector(articleWriteBaseCell:actionType:value:)]) {
        if (self.classes.count>btn.tag) {
            ArticleHomeClassItem *item = self.classes[btn.tag];
            [self.delegate articleWriteBaseCell:self actionType:ArticleWriteBaseCellActionTypeSelectClass value:item];
        }
    }
}


@end
