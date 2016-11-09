//
//  MultiItemsToolBarOpenView.m
//  KidsTC
//
//  Created by zhanping on 7/11/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "MultiItemsToolBarOpenView.h"
#import "UIButton+Category.h"

@interface MultiItemsToolBarOpenView ()
@property (nonatomic, strong) NSMutableArray<UIButton *> *tagBtns;
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation MultiItemsToolBarOpenView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.tagBtns = [NSMutableArray<UIButton *> array];
    }
    return self;
}

- (void)setTags:(NSArray<NSString *> *)tags{
    _tags = tags;
    
    if (self.tagBtns.count>0) {
        [self.tagBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.tagBtns removeAllObjects];
    }
    
    [tags enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [self btnWithTitle:obj tag:idx];
        [self addSubview:btn];
        [self.tagBtns addObject:btn];
    }];
    
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat btnW  = (self_w - (MAX_ListCount+1)*BTN_Margin)/MAX_ListCount;
    [self.tagBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger index_x = idx%MAX_ListCount;
        CGFloat btnX = BTN_Margin + (btnW+BTN_Margin)*index_x;
        CGFloat btnY = BTN_Margin + (BTN_Hight+BTN_Margin)*(idx/MAX_ListCount);
        btn.frame = CGRectMake(btnX, btnY, btnW, BTN_Hight);
    }];
}

- (UIButton *)btnWithTitle:(NSString *)title tag:(NSInteger)tag{
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = tag;
    btn.adjustsImageWhenHighlighted = NO;
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:COLOR_PINK forState:UIControlStateSelected];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    return btn;
}

- (void)btnClickAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(multiItemsToolBarOpenView:didSelectedIndex:)]) {
        [self.delegate multiItemsToolBarOpenView:self didSelectedIndex:btn.tag];
    }
    [self selectedBtnIndex:btn.tag];
}

- (void)selectedBtnIndex:(NSUInteger)index{
    
    self.selectedBtn.selected = NO;
    self.selectedBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UIButton *btn = self.tagBtns[index];
    btn.selected = YES;
    btn.layer.borderColor = [UIColor clearColor].CGColor;
    self.selectedBtn = btn;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

@end
