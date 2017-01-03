//
//  MultiItemsToolBar.m
//  KidsTC
//
//  Created by zhanping on 7/11/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "MultiItemsToolBar.h"
#import "MultiItemsToolBarOpenView.h"
#import "Macro.h"
#import "NSString+Category.h"
#define GradientLayerWidth 20
#define OpenTipLabelText @"    切换栏目"

@interface MultiItemsToolBar ()<MultiItemsToolBarScrollViewDelegate,MultiItemsToolBarOpenViewDelegate>
@property (nonatomic, weak) UILabel *openTipLabel;
@property (nonatomic, weak) UIButton *openBtn;
@property (nonatomic, weak) MultiItemsToolBarOpenView *openView;
@end

@implementation MultiItemsToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        MultiItemsToolBarOpenView *openView = [[MultiItemsToolBarOpenView alloc]init];
        [self addSubview:openView];
        openView.delegate = self;
        openView.hidden = YES;
        self.openView = openView;
        
        MultiItemsToolBarScrollView *scrollView = [[MultiItemsToolBarScrollView alloc]init];
        scrollView.clickDelegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        id whiteColor1 = (id)[UIColor whiteColor].CGColor;
        id whiteColor2 = (id)[UIColor colorWithWhite:1 alpha:0.2].CGColor;
        NSArray *colors = @[whiteColor1,whiteColor2];
        
        CAGradientLayer *leftLayer = [CAGradientLayer layer];
        leftLayer.colors = colors;
        leftLayer.startPoint = CGPointMake(0, 0);
        leftLayer.endPoint = CGPointMake(1, 0);
        leftLayer.locations = @[@(0.2)];
        [self.layer addSublayer:leftLayer];
        self.leftLayer = leftLayer;
        
        CAGradientLayer *rightLayer = [CAGradientLayer layer];
        rightLayer.colors = colors;
        rightLayer.startPoint = CGPointMake(1, 0);
        rightLayer.endPoint = CGPointMake(0, 0);
        rightLayer.locations = @[@(0.2)];
        [self.layer addSublayer:rightLayer];
        self.rightLayer = rightLayer;
        
        UILabel *openTipLabel = [[UILabel alloc]init];
        openTipLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:openTipLabel];
        openTipLabel.font = [UIFont systemFontOfSize:15];
        openTipLabel.textColor = [UIColor lightGrayColor];
        openTipLabel.alpha = 0;
        openTipLabel.text = OpenTipLabelText;
        openTipLabel.hidden = YES;
        openTipLabel.userInteractionEnabled = YES;
        self.openTipLabel = openTipLabel;
        
        UIButton *openBtn = [[UIButton alloc]init];
        [self addSubview:openBtn];
        openBtn.backgroundColor = [UIColor whiteColor];
        [openBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        [openBtn addTarget:self action:@selector(openBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        openBtn.adjustsImageWhenHighlighted = NO;
        openBtn.hidden = YES;
        self.openBtn = openBtn;
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        self.line = line;
    
    }
    return self;
}

- (void)setTags:(NSArray<NSString *> *)tags{
    
    NSMutableArray *tagsAry = [NSMutableArray array];
    [tags enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = [NSString stringWithFormat:@"%@",obj];
        if ([title isNotNull]) {
            [tagsAry addObject:title];
        }
    }];
    _tags = [NSArray arrayWithArray:tagsAry];
    
    self.scrollView.tags = _tags;
    
    self.line.hidden = _tags.count<=0;
    
    self.openView.tags = _tags;
    
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    
    CGFloat scrollView_w = self_w;
    CGFloat scrollView_h = MultiItemsToolBarScrollViewHeight;
    BOOL opBtnShow = self.scrollView.contentSize.width>self_w;
    if (opBtnShow) scrollView_w -= scrollView_h;
    self.scrollView.frame = CGRectMake(0, 0, scrollView_w, scrollView_h);
    
    self.openBtn.frame = CGRectMake(scrollView_w, 0, scrollView_h, scrollView_h);
    self.openBtn.hidden = !opBtnShow;
    
    self.openTipLabel.frame = CGRectMake(0, 0, self_w, MultiItemsToolBarScrollViewHeight);
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.leftLayer.frame = CGRectMake(0, 0, GradientLayerWidth, scrollView_h);
    self.rightLayer.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame)-GradientLayerWidth, 0, GradientLayerWidth, scrollView_h);
    [CATransaction commit];
    
    CGFloat line_h = 1.0/[UIScreen mainScreen].scale;
    CGFloat line_y = CGRectGetHeight(self.scrollView.frame)-line_h;
    self.line.frame = CGRectMake(0, line_y, self_w, line_h);
}

- (void)changeTipPlaceWithSmallIndex:(NSUInteger)smallIndex
                            bigIndex:(NSUInteger)bigIndex
                            progress:(CGFloat)progress
                             animate:(BOOL)animate
{
    [self.scrollView changeTipPlaceWithSmallIndex:smallIndex bigIndex:bigIndex progress:progress animate:animate];
}



- (void)openBtnAction:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self showWithSelectIndex:self.scrollView.selectedBtn.tag];
    }else{
        [self hide];
    }
}

#pragma mark - MultiItemsToolBarScrollViewDelegate

- (void)multiItemsToolBarScrollView:(MultiItemsToolBarScrollView *)multiItemsToolBarScrollView didSelectedIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(multiItemsToolBar:didSelectedIndex:)]) {
        [self.delegate multiItemsToolBar:self didSelectedIndex:index];
    }
}

#pragma mark - MultiItemsToolBarOpenViewDelegate

- (void)multiItemsToolBarOpenView:(MultiItemsToolBarOpenView *)multiItemsToolBarOpenView didSelectedIndex:(NSUInteger)index{
    [self multiItemsToolBarScrollView:self.scrollView didSelectedIndex:index];
    [self openBtnAction:self.openBtn];
}

#pragma mark - openView

- (void)showWithSelectIndex:(NSUInteger)index{
    
    [self.openView selectedBtnIndex:index];
    
    self.openTipLabel.hidden = NO;
    self.openView.hidden = NO;
    
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), SCREEN_WIDTH, SCREEN_HEIGHT);
    
    CGFloat scrollView_y = CGRectGetMaxY(self.scrollView.frame);
    
    NSUInteger rowCount = (self.tags.count+MAX_ListCount-1)/MAX_ListCount;
    CGFloat openView_x = 0;
    CGFloat openView_w = CGRectGetWidth(self.frame);
    CGFloat openView_h =  rowCount * (BTN_Hight + BTN_Margin) + BTN_Margin;
    CGFloat openView_y = scrollView_y - openView_h;
    self.openView.frame = CGRectMake(openView_x, openView_y, openView_w, openView_h);
    openView_y = scrollView_y;
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.openTipLabel.alpha = 1;
        self.openView.frame = CGRectMake(openView_x, openView_y, openView_w, openView_h);
        [self.openBtn.imageView setTransform:CGAffineTransformRotate(self.openBtn.imageView.transform, M_PI)];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    } completion:nil];
}

- (void)hide{
    
    CGFloat scrollView_y = CGRectGetMaxY(self.scrollView.frame);
    CGRect frame = self.openView.frame;
    frame.origin.y = scrollView_y - CGRectGetHeight(frame);
    [UIView animateWithDuration:0.3 animations:^{
        self.openTipLabel.alpha = 0;
        self.openView.frame = frame;
        [self.openBtn.imageView setTransform:CGAffineTransformRotate(self.openBtn.imageView.transform, M_PI)];
        
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), SCREEN_WIDTH, MultiItemsToolBarScrollViewHeight);
        self.openTipLabel.hidden = YES;
        self.openView.hidden = YES;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self openBtnAction:self.openBtn];
}

@end
