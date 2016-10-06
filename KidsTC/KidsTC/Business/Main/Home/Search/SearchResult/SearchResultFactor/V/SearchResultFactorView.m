//
//  SearchResultFactorView.m
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultFactorView.h"

#import "SearchResultFactorTopView.h"
#import "SearchResultFactorTablesContentView.h"
#import "SearchResultFactorBottomView.h"
#import "Macro.h"

#define SearchResultFactorBottomViewHeight 54
#define self_backgroundColor [UIColor colorWithWhite:0 alpha:0.5]
#define SearchResultFactorViewAnimationDuration 0.2

@interface SearchResultFactorView ()<SearchResultFactorTopViewDelegate,SearchResultFactorBottomViewDelegate,SearchResultFactorTablesContentViewDelegate>
@property (nonatomic, weak) SearchResultFactorTopView *topView;
@property (nonatomic, weak) SearchResultFactorTablesContentView *tablesContentView;
@property (nonatomic, weak) SearchResultFactorBottomView *bottomView;
@end

@implementation SearchResultFactorView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        [self addBottomView];
        
        [self addTableViewsContentView];
        
        [self addTopView];
    }
    return self;
}

- (void)addTopView{
    
    SearchResultFactorTopView *topView = [[SearchResultFactorTopView alloc]init];
    [self addSubview:topView];
    self.topView = topView;
    
    topView.delegate = self;
    
}

- (void)addTableViewsContentView{
    
    SearchResultFactorTablesContentView *tablesContentView = [[SearchResultFactorTablesContentView alloc]init];
    [self addSubview:tablesContentView];
    self.tablesContentView = tablesContentView;
    tablesContentView.delegate = self;
}

- (void)addBottomView{
    
    SearchResultFactorBottomView *bottomView = [[SearchResultFactorBottomView alloc]init];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    bottomView.hidden = YES;
    bottomView.delegate = self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    
    CGFloat topView_x = 0;
    CGFloat topView_y = 0;
    CGFloat topView_w = self_w;
    CGFloat topView_h = SearchResultFactorTopViewHight;
    self.topView.frame = CGRectMake(topView_x, topView_y, topView_w, topView_h);
}

- (void)setModel:(SearchResultFactorShowModel *)model{
    _model = model;
    [self hide];
    self.topView.items = model.items;
}

#pragma mark - SearchResultFactorTopViewDelegate

- (void)searchResultFactorTopView:(SearchResultFactorTopView *)searchResultFactorTopView
                    didClickOnBtn:(UIButton *)btn{
    
    if (btn.selected) {
        SearchResultFactorTopItem *item = self.model.items[btn.tag];
        self.bottomView.hidden = !(item.type == SearchResultFactorTopItemTypeFilter);
        self.tablesContentView.item = item;
        [self show];
    }else{
        [self hide];
    }
}

#pragma mark - SearchResultFactorTablesContentViewDelegate

- (void)tablesContentViewDidMakeSureData:(SearchResultFactorTablesContentView *)searchResultFactorTablesContentView{
    [self makeSureData];
}

#pragma mark - SearchResultFactorBottomViewDelegate

- (void)searchResultFactorBottomView:(SearchResultFactorBottomView *)searchResultFactorBottomView
                   didClickOnBtnType:(SearchResultFactorBottomViewClickType)type{
    switch (type) {
        case SearchResultFactorBottomViewClickType_CleanUp:
        {
            [self.tablesContentView operateDataWith:TablesContentViewOperaDataType_CleanUpSelected];
            [self.tablesContentView reloadData];
        }
            break;
        case SearchResultFactorBottomViewClickType_MakeSure:
        {
            [self.tablesContentView operateDataWith:TablesContentViewOperaDataType_MakeSureSelected];
            [self makeSureData];
        }
            break;
    }
}

- (void)makeSureData{
    
    [self.topView setBtnTitles];
    [self hide];
    
    if ([self.delegate respondsToSelector:@selector(factorViewDidMakeSureData:)]) {
        [self.delegate factorViewDidMakeSureData:self];
    }
}

- (void)show{
    
    CGRect self_frame = self.frame;
    self_frame.size.height = SCREEN_HEIGHT-64;
    self.frame = self_frame;
    
    CGFloat self_w = self_frame.size.width;
    CGFloat self_h = self_frame.size.height;
    
    CGFloat tablesContentView_x = 0;
    CGFloat tablesContentView_w = self_w;
    CGFloat tablesContentView_h1 = self.tablesContentView.contentHeight;
    CGFloat tablesContentView_h2 = (self_h-CGRectGetHeight(self.topView.frame))*0.8;
    CGFloat tablesContentView_h = tablesContentView_h1>=tablesContentView_h2?tablesContentView_h2:tablesContentView_h1;
    CGFloat tablesContentView_y = CGRectGetMaxY(self.topView.frame)-tablesContentView_h;
    
    CGRect tablesContentView_frame = CGRectMake(tablesContentView_x, tablesContentView_y, tablesContentView_w, tablesContentView_h);
    self.tablesContentView.frame = tablesContentView_frame;
    
    CGFloat bottom_x = 0;
    CGFloat bottom_w = self_w;
    CGFloat bottom_h = SearchResultFactorBottomViewHeight;
    CGFloat bottom_y = CGRectGetMaxY(self.tablesContentView.frame)-bottom_h;
    
    CGRect bottomView_frame = CGRectMake(bottom_x, bottom_y, bottom_w, bottom_h);
    self.bottomView.frame = bottomView_frame;
    
    tablesContentView_frame.origin.y = CGRectGetMaxY(self.topView.frame);
    bottomView_frame.origin.y = CGRectGetMaxY(tablesContentView_frame);
    
    [UIView animateWithDuration:SearchResultFactorViewAnimationDuration animations:^{
        self.backgroundColor = self_backgroundColor;
        self.tablesContentView.frame = tablesContentView_frame;
        self.bottomView.frame = bottomView_frame;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tablesContentView scrollToFirstSelectedItem];
        });
    }];
}

- (void)hide{
    
    [self.topView unselected];
    
    CGRect self_frame = self.frame;
    self_frame.size.height = SearchResultFactorTopViewHight;
    
    CGRect tablesContentView_frame = self.tablesContentView.frame;
    tablesContentView_frame.origin.y = CGRectGetMaxY(self.topView.frame) - CGRectGetHeight(tablesContentView_frame);
    
    CGRect bottomView_frame = self.bottomView.frame;
    bottomView_frame.origin.y = CGRectGetMaxY(tablesContentView_frame) - CGRectGetHeight(bottomView_frame);
    
    [UIView animateWithDuration:SearchResultFactorViewAnimationDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.tablesContentView.frame = tablesContentView_frame;
        self.bottomView.frame =  bottomView_frame;
    } completion:^(BOOL finished) {
        self.frame = self_frame;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hide];
}

@end
