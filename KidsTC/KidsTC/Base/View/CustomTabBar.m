//
//  CustomTabBar.m
//  KidsTC
//
//  Created by 詹平 on 16/4/10.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "CustomTabBar.h"
#import "Macro.h"

#define BTN_TITLE_HEIGHT 10
#define BTN_TITLE_BOTTOM_MARGIN 4
#define BTN_IMAGE_SIZE 24

CGFloat const normalImgSize = 26;
CGFloat const titleHight = 18;

@implementation CustomTabBarButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (self.element.type == TabBarItemElementTypeAdditional) {
        return CGRectMake(0, 0, CGRectGetWidth(contentRect), CGRectGetHeight(contentRect));
    }else{
        CGFloat imageX = (CGRectGetWidth(contentRect)-BTN_IMAGE_SIZE)*0.5;
        CGFloat imageY = (CGRectGetHeight(contentRect)-BTN_TITLE_BOTTOM_MARGIN-BTN_TITLE_HEIGHT-BTN_IMAGE_SIZE)*0.5;
        return CGRectMake(imageX, imageY, BTN_IMAGE_SIZE, BTN_IMAGE_SIZE);
    }
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (self.element.type == TabBarItemElementTypeAdditional) {
        return CGRectZero;
    } else {
        CGFloat titleW = CGRectGetWidth(contentRect);
        CGFloat titleY = CGRectGetHeight(contentRect)-BTN_TITLE_HEIGHT-BTN_TITLE_BOTTOM_MARGIN;
        return CGRectMake(0, titleY, titleW, BTN_TITLE_HEIGHT);
    }
}
- (void)setHighlighted:(BOOL)highlighted{
    //if (self.element.type == TabBarItemElementTypeAdditional)[super setHighlighted:highlighted];
}

- (void)setElement:(TabBarItemElement *)element{
    _element = element;
    //1.设置标题
    if (element.title.length>0) [self setTitle:element.title forState:UIControlStateNormal];
    //2.设置标题颜色
    if (element.color_Nor) [self setTitleColor:element.color_Nor forState:UIControlStateNormal];
    if (element.color_Sel) [self setTitleColor:element.color_Sel forState:UIControlStateDisabled];
    //3.设置图片
    if (element.image_Nor) [self setImage:element.image_Nor forState:UIControlStateNormal];
    if (element.image_Sel) [self setImage:element.image_Sel forState:UIControlStateDisabled];
}

@end

@interface CustomTabBar ()
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) CustomTabBarButton *currentBtn;
@end

@implementation CustomTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[UITabBar appearance] setBackgroundImage:[UIImage new]];
        [[UITabBar appearance] setShadowImage:[UIImage new]];
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        
        [UITabBar appearance].backgroundImage = [UIImage new];
        [UITabBar appearance].shadowImage = [UIImage new];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = COLOR_LINE;
        [self addSubview:line];
        self.line  = line;
        
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -2);
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 0.5;
    }
    return self;
}

- (void)setElements:(NSArray<TabBarItemElement *> *)elements{
    _elements = elements;
    
    NSMutableArray *btns = [NSMutableArray array];
    for (TabBarItemElement *element in elements) {
        CustomTabBarButton *btn = [[CustomTabBarButton alloc]init];
        btn.element = element;
        [self addSubview:btn];
        [btns addObject:btn];
        [btn addTarget:self action:@selector(didClickTCButton:) forControlEvents:UIControlEventTouchDown];
    }
    self.btns = btns;
    
    if(self.btns.count>0) [self selectIndex:0];
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.line.frame = CGRectMake(0, 0, self.bounds.size.width, LINE_H);
    
    CGFloat btnY = 0, btnH = self.bounds.size.height, btnW = self.bounds.size.width/self.btns.count;
    for (int i = 0; i<self.btns.count; i++) {
        CGFloat btnX = btnW * i;
        CustomTabBarButton *btn = self.btns[i];
        if (btn.element.type == TabBarItemElementTypeAdditional) {
            btn.frame = CGRectMake(btnX, btnH - btnW, btnW, btnW);
        }else{
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        }
    }
}

- (void)didClickTCButton:(CustomTabBarButton *)btn{
    NSUInteger index = [self.btns indexOfObject:btn];
    [self selectIndex:index];
}

- (void)selectIndex:(NSUInteger)index{
    
    if (index>self.btns.count-1) return;
    CustomTabBarButton *btn = self.btns[index];
    if ([self.delegate respondsToSelector:@selector(customTabBar:didSelectIndex:)]) {
        [self.delegate customTabBar:self didSelectIndex:index];
    }
    self.currentBtn.enabled = YES;
    btn.enabled = NO;
    self.currentBtn = btn;
}

- (void)makeBadgeIndex:(NSUInteger)index type:(TipButtonBadgeType)type value:(NSUInteger)value{
    if (index>self.btns.count-1) return;
    CustomTabBarButton *btn = self.btns[index];
    btn.badgeType = type; btn.badgeValue = value;
}

- (void)clearBadgeIndex:(NSUInteger)index{
    if (index>self.btns.count-1) return;
    self.btns[index].badgeValue = 0;
}

@end
