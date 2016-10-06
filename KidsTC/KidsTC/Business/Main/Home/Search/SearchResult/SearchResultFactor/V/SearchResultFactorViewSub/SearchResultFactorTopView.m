//
//  SearchResultFactorTopView.m
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultFactorTopView.h"
#import "Macro.h"

#define SearchResultFactorTopViewButtonTitleFont [UIFont systemFontOfSize:15]

@interface SearchResultFactorTopViewButton : UIButton
@property (nonatomic, weak) UIView *bottomTipView;
@property (nonatomic, weak) UIView *leftTipView;
@end

@implementation SearchResultFactorTopViewButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = SearchResultFactorTopViewButtonTitleFont;
        
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:COLOR_PINK forState:UIControlStateSelected];
        
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"arrow_up_red"] forState:UIControlStateSelected];
        
        UIView *bottomTipView = [[UIView alloc]init];
        [self addSubview:bottomTipView];
        self.bottomTipView = bottomTipView;
        bottomTipView.backgroundColor = COLOR_PINK;
        bottomTipView.hidden = YES;
        
        UIView *leftTipView = [[UIView alloc]init];
        [self addSubview:leftTipView];
        self.leftTipView = leftTipView;
        leftTipView.backgroundColor = COLOR_PINK;
        leftTipView.hidden = YES;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    NSString *title = [self titleForState:UIControlStateNormal];
    CGFloat title_w = [title sizeWithAttributes:@{NSFontAttributeName:SearchResultFactorTopViewButtonTitleFont}].width;
    CGFloat title_maxW = SCREEN_WIDTH/3-30;
    if (title_w>title_maxW) {
        title_w = title_maxW;
    }
    CGFloat title_h = CGRectGetHeight(contentRect);
    CGFloat title_x = (CGRectGetWidth(contentRect) - title_w) * 0.5;
    CGFloat title_y = 0;
    return CGRectMake(title_x, title_y, title_w, title_h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    NSString *title = [self titleForState:UIControlStateNormal];
    CGFloat title_w = [title sizeWithAttributes:@{NSFontAttributeName:SearchResultFactorTopViewButtonTitleFont}].width;
    CGFloat title_maxW = SCREEN_WIDTH/3-30;
    if (title_w>title_maxW) {
        title_w = title_maxW;
    }
    CGFloat imageSize = 10;
    CGFloat image_x = (CGRectGetWidth(contentRect) + title_w) * 0.5 + 3;
    CGFloat image_y = (CGRectGetHeight(contentRect) - imageSize) * 0.5;
    return CGRectMake(image_x, image_y, imageSize, imageSize);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat bottomTipView_w = CGRectGetWidth(self.frame);
    CGFloat bottomTipView_h = 2;
    CGFloat bottomTipView_x = 0;
    CGFloat bottomTipView_y = CGRectGetHeight(self.frame) - bottomTipView_h;
    self.bottomTipView.frame = CGRectMake(bottomTipView_x, bottomTipView_y, bottomTipView_w, bottomTipView_h);
    
    CGFloat leftTipView_size = 6;
    CGFloat leftTipView_x = self.titleLabel.frame.origin.x - leftTipView_size-3;
    CGFloat leftTipView_y = (CGRectGetHeight(self.frame) - leftTipView_size)*0.5;
    self.leftTipView.frame = CGRectMake(leftTipView_x, leftTipView_y, leftTipView_size, leftTipView_size);
    self.leftTipView.layer.cornerRadius = leftTipView_size*0.5;
    self.leftTipView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.bottomTipView.hidden = !selected;
}

@end

@interface SearchResultFactorTopView ()
@property (nonatomic, weak) UIView *line;
@property (nonatomic, strong) NSMutableArray<SearchResultFactorTopViewButton *> *btns;
@property (nonatomic, strong) NSMutableArray<UIView *> *verticalLines;
@property (nonatomic, weak) UIButton *lastClickedBtn;//用于记录最后一次被点击的按钮
@end

@implementation SearchResultFactorTopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addLine];
    }
    return self;
}

- (void)addLine{
    
    UIView *line = [[UIView alloc]init];
    [self addSubview:line];
    self.line = line;
    line.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    
    CGFloat line_x = 0;
    CGFloat line_w = self_w;
    CGFloat line_h = LINE_H;
    CGFloat line_y = self_h - line_h;
    self.line.frame = CGRectMake(line_x, line_y, line_w, line_h);
    
    
    NSUInteger btnsCount = self.btns.count;
    if (btnsCount<=0) return;
    NSUInteger verticalLinesCount = self.verticalLines.count;
    
    CGFloat verticalLine_w = LINE_H;
    CGFloat verticalLine_h = self_h * 0.5;
    CGFloat verticalLine_y = (self_h - verticalLine_h) * 0.5;
    CGFloat verticalLine_x = 0;
    
    CGFloat btn_w = (self_w - verticalLinesCount * verticalLine_w)/btnsCount;
    CGFloat btn_h = self_h - line_h;
    CGFloat btn_y = 0;
    CGFloat btn_x = 0;
    
    UIButton *lastBtn = nil;
    UIView *lastVerticalLine = nil;
    
    for (int i = 0; i<btnsCount; i++) {
        
        UIButton *btn = self.btns[i];
        if (lastVerticalLine) btn_x = CGRectGetMaxX(lastVerticalLine.frame);
        btn.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
        lastBtn = btn;
        
        if (i<verticalLinesCount) {
            UIView *verticalLine = self.verticalLines[i];
            if (lastBtn) verticalLine_x = CGRectGetMaxX(lastBtn.frame);
            verticalLine.frame = CGRectMake(verticalLine_x, verticalLine_y, verticalLine_w, verticalLine_h);
            lastVerticalLine = verticalLine;
        }
    }
}


- (void)setItems:(NSArray<SearchResultFactorTopItem *> *)items{
    _items = items;
    
    if (self.btns.count>0) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.btns removeAllObjects];
    }
    if (self.verticalLines.count>0) {
        [self.verticalLines makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.verticalLines removeAllObjects];
    }
    
    __block NSMutableArray<SearchResultFactorTopViewButton *> *btns = [NSMutableArray<SearchResultFactorTopViewButton *> array];
    __block NSMutableArray<UIView *> *verticalLines = [NSMutableArray<UIView *> array];
    NSUInteger count = items.count;
    [items enumerateObjectsUsingBlock:^(SearchResultFactorTopItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SearchResultFactorTopViewButton *btn = [self btnWithTag:idx];
        [self setTitleWithBtn:btn obj:obj];
        [self addSubview:btn];
        [btns addObject:btn];
        
        if (idx != count-1) {
            UIView *verticalLine = [UIView new];
            verticalLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self addSubview:verticalLine];
            [verticalLines addObject:verticalLine];
        }
    }];
    
    self.btns = btns;
    self.verticalLines = verticalLines;
}

- (void)setBtnTitles{
    [self.items enumerateObjectsUsingBlock:^(SearchResultFactorTopItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SearchResultFactorTopViewButton *btn = self.btns[idx];
        [self setTitleWithBtn:btn obj:obj];
    }];
}
- (void)setTitleWithBtn:(SearchResultFactorTopViewButton *)btn obj:(SearchResultFactorTopItem *)obj{
    NSString *btnTitle = obj.title;
    SearchResultFactorItem *item = [SearchResultFactorItem firstSelectedSubItem:obj];
    if (item) {
        switch (obj.type) {
            case SearchResultFactorTopItemTypeFilter:
            {
                btn.leftTipView.hidden = NO;
            }
                break;
                
            default:
            {
                btnTitle = item.title;
                btn.leftTipView.hidden = YES;
            }
                break;
        }
    }else{
        btn.leftTipView.hidden = YES;
    }
    [btn setTitle:btnTitle forState:UIControlStateNormal];
}

- (SearchResultFactorTopViewButton *)btnWithTag:(NSUInteger)tag{
    
    SearchResultFactorTopViewButton *btn = [[SearchResultFactorTopViewButton alloc]init];
    btn.tag = tag;
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)unselected{
    if (self.lastClickedBtn.selected) {
        self.lastClickedBtn.selected = NO;
    }
}

- (void)action:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (self.lastClickedBtn && self.lastClickedBtn != btn) {
        self.lastClickedBtn.selected = NO;
    }
    self.lastClickedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(searchResultFactorTopView:didClickOnBtn:)]) {
        [self.delegate searchResultFactorTopView:self didClickOnBtn:btn];
    }
}

@end
