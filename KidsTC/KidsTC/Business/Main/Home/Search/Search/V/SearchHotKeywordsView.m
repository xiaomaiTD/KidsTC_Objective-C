//
//  HotKeyView.m
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchHotKeywordsView.h"
#import "Macro.h"
#import "UIButton+Category.h"

#define ONE_LINE_HIGHT 50
#define BTN_HIGHT 26
#define HotKeyViewBtnFont [UIFont systemFontOfSize:13]
#define HotKeyViewBtnMargin 10
#define HotKeyViewMarginInset 10

@interface SearchHotKeywordsViewButton : UIButton
@end

@implementation SearchHotKeywordsViewButton
- (void)setHighlighted:(BOOL)highlighted{}
@end


@interface SearchHotKeywordsView ()
@property (nonatomic, strong) NSArray<SearchHotKeywordsListItem *> *searchHotKeywordsList;
@property (nonatomic, weak) UILabel *tipLabel;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;
@end

@implementation SearchHotKeywordsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.btns = [NSMutableArray array];
        
        UILabel *tipLabel= [[UILabel alloc] init];
        tipLabel.backgroundColor = [UIColor whiteColor];
        tipLabel.font = [UIFont boldSystemFontOfSize:15];
        [tipLabel setTextColor:[UIColor darkGrayColor]];
        [self addSubview:tipLabel];
        self.tipLabel = tipLabel;
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
    }
    return self;
}

- (void)setSearchHotKeywordsList:(NSArray<SearchHotKeywordsListItem *> *)searchHotKeywordsList hasSearchHistory:(BOOL)hasSearchHistory{
    _searchHotKeywordsList = searchHotKeywordsList;
    
    if (self.btns.count>0) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.btns removeAllObjects];
    }
    
    if (hasSearchHistory) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, ONE_LINE_HIGHT+HotKeyViewMarginInset);
        CGFloat h = ONE_LINE_HIGHT;
        CGFloat w = SCREEN_WIDTH;
        
        self.tipLabel.text = @"   热搜";
        self.tipLabel.frame = CGRectMake(0, 0, 50, h);
        
        CGFloat tipLabel_w = CGRectGetWidth(self.tipLabel.frame);
        self.scrollView.frame = CGRectMake(tipLabel_w, 0, w-tipLabel_w, h);
        
        
        __block UIButton *lastBtn = nil;
        [searchHotKeywordsList enumerateObjectsUsingBlock:^(SearchHotKeywordsListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [self btnWithTitle:obj.name tag:idx];
            CGFloat btnW = [obj.name sizeWithAttributes:@{NSFontAttributeName:HotKeyViewBtnFont}].width+16;
            CGFloat btnH = BTN_HIGHT;
            CGFloat btnX = HotKeyViewBtnMargin;
            CGFloat btnY = (h - btnH)*0.5;
            if (lastBtn) {
                btnX = CGRectGetMaxX(lastBtn.frame) + HotKeyViewBtnMargin;
            }
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [self.scrollView addSubview:btn];
            [self.btns addObject:btn];
            lastBtn = btn;
        }];
        
        [self.scrollView setContentSize:CGSizeMake(CGRectGetMaxX(lastBtn.frame)+HotKeyViewBtnMargin, CGRectGetHeight(self.scrollView.frame))];
        
    }else{
        
        CGFloat w = SCREEN_WIDTH;
        self.tipLabel.text = @"   热门搜索";
        self.tipLabel.frame = CGRectMake(0, 0, w, ONE_LINE_HIGHT);
        
        CGFloat scrollView_w = w;
        __block UIButton *lastBtn = nil;
        [searchHotKeywordsList enumerateObjectsUsingBlock:^(SearchHotKeywordsListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [self btnWithTitle:obj.name tag:idx];
            CGFloat btnW = [obj.name sizeWithAttributes:@{NSFontAttributeName:HotKeyViewBtnFont}].width+16;
            CGFloat btnH = BTN_HIGHT;
            CGFloat btnX = HotKeyViewMarginInset;
            CGFloat btnY = 0;
            if (lastBtn) {
                btnX = CGRectGetMaxX(lastBtn.frame) + HotKeyViewBtnMargin;
                btnY = lastBtn.frame.origin.y;
            }
            if (btnX+btnW+HotKeyViewMarginInset>scrollView_w) {
                btnY = lastBtn.frame.origin.y+HotKeyViewBtnMargin+BTN_HIGHT;
                btnX = HotKeyViewMarginInset;
            }
            
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [self.scrollView addSubview:btn];
            [self.btns addObject:btn];
            lastBtn = btn;
        }];
        CGFloat scrollView_h = CGRectGetMaxY(lastBtn.frame)+HotKeyViewMarginInset;
        
        [self.scrollView setContentSize:CGSizeMake(scrollView_w, scrollView_h)];
        
        self.scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame), scrollView_w, scrollView_h);
        
        self.frame = CGRectMake(0, 0, w, CGRectGetMaxY(self.scrollView.frame));
    }
    
}

- (UIButton *)btnWithTitle:(NSString *)title tag:(NSUInteger)tag{
    SearchHotKeywordsViewButton *btn = [[SearchHotKeywordsViewButton alloc]init];
    btn.titleLabel.font = HotKeyViewBtnFont;
    [btn setBackgroundColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
    //[UIColor colorWithRed:0.961  green:0.961  blue:0.961 alpha:1]
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)clickAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(searchHotKeywordsView:didClickBtnIndex:)]) {
        [self.delegate searchHotKeywordsView:self didClickBtnIndex:btn.tag];
    }
}


@end
