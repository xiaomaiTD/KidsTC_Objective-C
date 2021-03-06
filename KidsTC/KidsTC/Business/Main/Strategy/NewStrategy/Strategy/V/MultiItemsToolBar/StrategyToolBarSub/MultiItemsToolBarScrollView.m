//
//  MultiItemsToolBarScrollView.m
//  KidsTC
//
//  Created by zhanping on 7/11/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "MultiItemsToolBarScrollView.h"

#define BtnMargin 20
#define TipViewHeight 2

@interface MultiItemsToolBarScrollView ()
@property (nonatomic, strong) NSMutableArray<UIButton *> *tagBtns;
@property (nonatomic, weak) UIView *tipView;

@end

@implementation MultiItemsToolBarScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.tagBtns = [NSMutableArray<UIButton *> array];
        
        UIView *tipView = [[UIView alloc]init];
        tipView.backgroundColor = COLOR_PINK;
        [self addSubview:tipView];
        self.tipView = tipView;
    }
    return self;
}

- (void)setTags:(NSArray<NSString *> *)tags{
    _tags = tags;
    
    if (self.tagBtns.count>0) {
        [self.tagBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.tagBtns removeAllObjects];
    }
    
    [tags enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [self btnWithTitle:obj tag:idx];
        [self addSubview:btn];
        [self.tagBtns addObject:btn];
    }];
    
    [self bringSubviewToFront:self.tipView];
    
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger tagsCount = self.tagBtns.count;
    
    if (tagsCount>4) {
        [self setupLayoutsOne];
    }else{
        [self setupLayoutsTwo];
    }
}

- (void)setupLayoutsOne {
    
    __block CGFloat currentWidth = BtnMargin;
    [self.tagBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat btn_w = [btn.currentTitle sizeWithAttributes:@{NSFontAttributeName:btn.titleLabel.font}].width;
        btn.frame = CGRectMake(currentWidth, 0, btn_w, MultiItemsToolBarScrollViewHeight);
        currentWidth += (btn_w+BtnMargin);
    }];
    self.contentSize = CGSizeMake(currentWidth, MultiItemsToolBarScrollViewHeight);
}

- (void)setupLayoutsTwo {
    
    NSUInteger tagsCount = self.tagBtns.count;
    CGFloat self_w = CGRectGetWidth(self.bounds);
    __block CGFloat totalBtnsWidth = 0;
    NSMutableArray *btn_ws = [NSMutableArray array];
    [self.tagBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat btn_w = [btn.currentTitle sizeWithAttributes:@{NSFontAttributeName:btn.titleLabel.font}].width;
        totalBtnsWidth += btn_w ;
        [btn_ws addObject:@(btn_w)];
    }];
    CGFloat needWith = totalBtnsWidth + BtnMargin * (tagsCount + 1);
    if (needWith >self_w) {
        [self setupLayoutsOne];
    }else{
        CGFloat margin = (self_w - totalBtnsWidth)/(tagsCount+1);
        __block CGFloat currentWidth = margin;
        [btn_ws enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat btn_w = [obj floatValue];
            if (idx<tagsCount) {
                UIButton *btn = self.tagBtns[idx];
                btn.frame = CGRectMake(currentWidth, 0, btn_w, MultiItemsToolBarScrollViewHeight);
                currentWidth += (btn_w + margin);
            }
        }];
    }
}

- (UIButton *)btnWithTitle:(NSString *)title tag:(NSUInteger)tag{
    
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = tag;
    [btn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_PINK forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    
    return btn;
}

- (void)selectedAction:(UIButton *)btn{
    
    if ([self.clickDelegate respondsToSelector:@selector(multiItemsToolBarScrollView:didSelectedIndex:)]) {
        [self.clickDelegate multiItemsToolBarScrollView:self didSelectedIndex:btn.tag];
    }
}

- (void)selectedBtnIndex:(NSUInteger)index
                 animate:(BOOL)animate
{
    if (self.tagBtns.count<1 || index>self.tagBtns.count-1) {
        return;
    }
    
    CGFloat self_h = CGRectGetHeight(self.frame);
    
    UIButton *btn = self.tagBtns[index];
    CGFloat tipView_x = btn.frame.origin.x;
    CGFloat tipView_w = btn.frame.size.width;
    CGFloat tipView_h = TipViewHeight;
    CGFloat tipView_y = self_h-tipView_h;
    CGRect tipView_frame = CGRectMake(tipView_x, tipView_y, tipView_w, tipView_h);
    
    NSTimeInterval duration = animate?0.2:0.0;
    [UIView animateWithDuration:duration animations:^{
        
        self.tipView.frame = tipView_frame;
        
        CGFloat maxOffsetX = self.contentSize.width-self.frame.size.width;
        if (maxOffsetX>=0) {
            CGFloat offsetX = btn.center.x-self.frame.size.width*0.5;
            CGFloat minOffsetX = 0;
            
            if (offsetX < minOffsetX) {
                offsetX = minOffsetX;
            }else if (offsetX > maxOffsetX) {
                offsetX = maxOffsetX;
            }
            
            [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }
    }];
    
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

- (void)changeTipPlaceWithSmallIndex:(NSUInteger)smallIndex
                            bigIndex:(NSUInteger)bigIndex
                            progress:(CGFloat)progress
                             animate:(BOOL)animate
{
        
    if (smallIndex>=self.tagBtns.count) {
        smallIndex = self.tagBtns.count-1;
    }
    if (bigIndex>=self.tagBtns.count) {
        bigIndex = self.tagBtns.count-1;
    }
    
    if (progress==0) {
        [self selectedBtnIndex:smallIndex animate:animate];
    }else{
        UIButton *btn1 = self.tagBtns[smallIndex];
        UIButton *btn2 = self.tagBtns[bigIndex];
        
        CGFloat btn1X = btn1.frame.origin.x;
        CGFloat btn2X = btn2.frame.origin.x;
        CGFloat btn1W = btn1.frame.size.width;
        CGFloat btn2W = btn2.frame.size.width;
        
        CGFloat marginX = btn2X-btn1X;
        CGFloat marginW = btn2W-btn1W;
        
        if (smallIndex == self.tagBtns.count-1) {marginX = 40;}
        
        CGFloat x = btn1X+marginX*progress;
        CGFloat w = btn1W+marginW*progress;
        
        CGRect frame = self.tipView.frame;
        frame.origin.x = x;
        frame.size.width = w;
        self.tipView.frame = frame;
    }
}

@end
