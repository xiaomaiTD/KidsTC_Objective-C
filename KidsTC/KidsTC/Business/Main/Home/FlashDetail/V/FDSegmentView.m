//
//  FDToolBarView.m
//  KidsTC
//
//  Created by zhanping on 5/18/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FDSegmentView.h"
// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define btnWidth SCREEN_WIDTH/3.0
@interface FDSegmentView ()

@property (nonatomic, weak) UIView *currentLine;
@end
@implementation FDSegmentView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIVisualEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:visualEffect];
        [self addSubview:visualEffectView];
        
        UIButton *serveDetailBtn = [self btnWithTitle:@"服务详情"];
        serveDetailBtn.tag = FDSegmentViewBtnType_ServeDetail;
        [self addSubview:serveDetailBtn];
        
        UIButton *storeBtn = [self btnWithTitle:@"门店"];
        storeBtn.tag = FDSegmentViewBtnType_Store;
        [self addSubview:storeBtn];
        
        UIButton *commentBtn = [self btnWithTitle:@"评论"];
        commentBtn.tag = FDSegmentViewBtnType_Comment;
        [self addSubview:commentBtn];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        UIView *currentLine = [[UIView alloc]init];
        currentLine.backgroundColor = COLOR_PINK;
        [self addSubview:currentLine];
        
        self.currentLine = currentLine;
        
        [visualEffectView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
        }];
        
        [serveDetailBtn makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(btnWidth);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(0);
        }];
        
        [storeBtn makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(btnWidth);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(btnWidth);
        }];
        
        [commentBtn makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(btnWidth);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(btnWidth*2);
        }];
        
        CGFloat lineW = LINE_H;
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, lineW));
            make.left.equalTo(0);
            make.bottom.equalTo(-lineW);
        }];
        
        [self toolBarBtnClick:serveDetailBtn];
    }
    return self;
}

- (UIButton *)btnWithTitle:(NSString *)title{
    UIButton *btn = [[UIButton alloc]init];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_PINK forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(toolBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)toolBarBtnClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [self.currentLine remakeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(btnWidth, 2));
        make.bottom.equalTo(0);
        make.centerX.equalTo(btn);
    }];
    
    if ([self.delegate respondsToSelector:@selector(segmentView:didClickBtnType:)]) {
        [self.delegate segmentView:self didClickBtnType:(FDSegmentViewBtnType)btn.tag];
    }
}

@end