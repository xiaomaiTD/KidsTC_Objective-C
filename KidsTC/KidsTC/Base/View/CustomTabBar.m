//
//  CustomTabBar.m
//  KidsTC
//
//  Created by 詹平 on 16/4/10.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "CustomTabBar.h"
#import "Macro.h"
#import "UIButton+WebCache.h"
#import "ComposeManager.h"
#import "NSString+Category.h"

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
    TabBarItemElementType type = self.element.type;
    if (type == TabBarItemElementTypeAddLink) {
        return CGRectMake(0, 0, CGRectGetWidth(contentRect), CGRectGetHeight(contentRect));
    } else if (type == TabBarItemElementTypeAddCompose) {
        return CGRectMake(0, 0, CGRectGetWidth(contentRect), CGRectGetHeight(contentRect));
    }else{
        CGFloat imageX = (CGRectGetWidth(contentRect)-BTN_IMAGE_SIZE)*0.5;
        CGFloat imageY = (CGRectGetHeight(contentRect)-BTN_TITLE_BOTTOM_MARGIN-BTN_TITLE_HEIGHT-BTN_IMAGE_SIZE)*0.5;
        return CGRectMake(imageX, imageY, BTN_IMAGE_SIZE, BTN_IMAGE_SIZE);
    }
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    TabBarItemElementType type = self.element.type;
    if (type == TabBarItemElementTypeAddLink) {
        return CGRectZero;
    } else if (type == TabBarItemElementTypeAddCompose) {
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
    if (element.color_Sel) [self setTitleColor:element.color_Sel forState:UIControlStateSelected];
    //3.设置图片
    if (element.image_Nor) [self setImage:element.image_Nor forState:UIControlStateNormal];
    if (element.image_Sel) [self setImage:element.image_Sel forState:UIControlStateSelected];
}

@end

@interface CustomTabBar ()
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) CustomTabBarButton *currentBtn;
@property (nonatomic, strong) CustomTabBarButton *addLinkBtn;
@property (nonatomic, strong) TabBarItemElement *addLinkEle;
@property (nonatomic, strong) TabBarItemElement *codedEle;
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
    CustomTabBarButton *addLinkBtn = nil;
    TabBarItemElement *addLinkEle = nil;
    for (TabBarItemElement *element in elements) {
        CustomTabBarButton *btn = [[CustomTabBarButton alloc]init];
        btn.element = element;
        [self addSubview:btn];
        [btns addObject:btn];
        [btn addTarget:self action:@selector(didClickTCButton:) forControlEvents:UIControlEventTouchDown];
        if (element.type == TabBarItemElementTypeAddLink) {
            addLinkBtn = btn;
            addLinkEle = element;
        }
    }
    self.btns = btns;
    self.addLinkBtn = addLinkBtn;
    self.addLinkEle = addLinkEle;
    
    if(btns.count>0) [self didClickTCButton:btns[0]];
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.line.frame = CGRectMake(0, 0, self.bounds.size.width, LINE_H);
    
    CGFloat btnY = 0, btnH = self.bounds.size.height, btnW = self.bounds.size.width/self.btns.count;
    for (int i = 0; i<self.btns.count; i++) {
        CGFloat btnX = btnW * i;
        CustomTabBarButton *btn = self.btns[i];
        TabBarItemElementType type = btn.element.type;
        if (type == TabBarItemElementTypeAddLink ||
            type == TabBarItemElementTypeAddCompose)
        {
            btn.frame = CGRectMake(btnX, btnH - btnW, btnW, btnW);
        }else{
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        }
    }
}

- (void)selectIndex:(NSUInteger)index {
    if(self.btns.count>index) [self didClickTCButton:self.btns[index]];
}

- (void)didClickTCButton:(CustomTabBarButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(customTabBar:didSelectElementType:)]) {
        [self.delegate customTabBar:self didSelectElementType:btn.element.type];
    }
    
    [self dealiWithCompose:btn];
    
    self.currentBtn.selected = NO;
    btn.selected = YES;
    self.currentBtn = btn;
    
}

- (void)dealiWithCompose:(CustomTabBarButton *)btn{
    
    if (self.addLinkBtn && self.addLinkEle) {
        TabBarItemElementType type = btn.element.type;
        
        if (type == TabBarItemElementTypeArticle ||
            type == TabBarItemElementTypeAddCompose)
        {
            self.addLinkBtn.element = self.codedEle;
            [self.addLinkBtn setNeedsLayout];
            [self.addLinkBtn layoutIfNeeded];
        } else {
            self.addLinkBtn.element = self.addLinkEle;
            [self.addLinkBtn setNeedsLayout];
            [self.addLinkBtn layoutIfNeeded];
        }
    }
}

- (TabBarItemElement *)codedEle{
    if (!_codedEle) {
        _codedEle = [TabBarItemElement addEleWithFImgName:@"tabBar_compose" sImgName:@"tabBar_compose"];
        ComposeBtn *middleBtn = [ComposeManager shareComposeManager].model.data.data.middleBtn;
        NSString *imgUrl = middleBtn.iconUrl;
        ComposeBtnIconType iconCode = middleBtn.iconCode;
        if (iconCode == ComposeBtnIconTypeUrl &&
            [imgUrl isNotNull]) {
            [self.addLinkBtn sd_setImageWithURL:[NSURL URLWithString:imgUrl]
                                       forState:UIControlStateNormal
                               placeholderImage:[UIImage imageNamed:@"tabBar_compose"]
                                      completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType,NSURL *imageURL)
             {
                 _codedEle.image_Nor = image;
                 _codedEle.image_Sel = image;
                 [self.addLinkBtn setNeedsLayout];
                 [self.addLinkBtn layoutIfNeeded];
             }];
        }
    }
    return _codedEle;
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
