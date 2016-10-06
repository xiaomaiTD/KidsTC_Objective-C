//
//  SearchResultFactorBottomView.m
//  KidsTC
//
//  Created by zhanping on 6/30/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultFactorBottomView.h"
#import "UIButton+Category.h"
#import "Macro.h"

#define SearchResultFactorBottomViewButtonHeight 40
#define SearchResultFactorBottomViewButtonMargin 12

@interface SearchResultFactorBottomView ()
@property (nonatomic, weak) UIButton *cleanUpBtn;
@property (nonatomic, weak) UIButton *sureBtn;
@end

@implementation SearchResultFactorBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIButton *cleanUpBtn = [self btnWithTitle:@"清除" btnType:SearchResultFactorBottomViewClickType_CleanUp];
        [self addSubview:cleanUpBtn];
        self.cleanUpBtn = cleanUpBtn;
        [cleanUpBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
        [cleanUpBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        UIButton *sureBtn = [self btnWithTitle:@"确定" btnType:SearchResultFactorBottomViewClickType_MakeSure];
        [self addSubview:sureBtn];
        self.sureBtn = sureBtn;
        [sureBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (UIButton *)btnWithTitle:(NSString *)title btnType:(SearchResultFactorBottomViewClickType)type{
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = (SearchResultFactorBottomViewClickType)type;
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setAdjustsImageWhenHighlighted:NO];
    btn.layer.cornerRadius = 2;
    UIColor *borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = LINE_H;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    
    CGFloat cleanUpBtn_x = SearchResultFactorBottomViewButtonMargin;
    CGFloat cleanUpBtn_y = (self_h - SearchResultFactorBottomViewButtonHeight) * 0.5;
    CGFloat cleanUpBtn_w = (self_w - 3 * SearchResultFactorBottomViewButtonMargin)/2;
    CGFloat cleanUpBtn_h = SearchResultFactorBottomViewButtonHeight;
    self.cleanUpBtn.frame = CGRectMake(cleanUpBtn_x, cleanUpBtn_y, cleanUpBtn_w, cleanUpBtn_h);
    
    CGFloat suerBtn_x = CGRectGetMaxX(self.cleanUpBtn.frame) + SearchResultFactorBottomViewButtonMargin;
    CGFloat suerBtn_y = cleanUpBtn_y;
    CGFloat suerBtn_w = cleanUpBtn_w;
    CGFloat suerBtn_h = cleanUpBtn_h;
    self.sureBtn.frame = CGRectMake(suerBtn_x, suerBtn_y, suerBtn_w, suerBtn_h);
    
}

- (void)action:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(searchResultFactorBottomView:didClickOnBtnType:)]) {
        [self.delegate searchResultFactorBottomView:self didClickOnBtnType:(SearchResultFactorBottomViewClickType)btn.tag];
    }
}

@end
