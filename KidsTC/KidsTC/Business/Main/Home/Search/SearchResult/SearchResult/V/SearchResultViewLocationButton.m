//
//  SearchResultViewLocationButton.m
//  KidsTC
//
//  Created by 詹平 on 16/7/8.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import "SearchResultViewLocationButton.h"
#define SearchResultViewLocationButtonImageSize 20
#define SearchResultViewLocationButtonImageMargin 6

@interface SearchResultViewLocationButton ()
@property (nonatomic, weak) UIView *line;
@end

@implementation SearchResultViewLocationButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.9];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UIView *line = [[UIView alloc]init];
        [self addSubview:line];
        line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        self.line = line;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat self_h = contentRect.size.height;
    
    CGFloat image_x = SearchResultViewLocationButtonImageMargin;
    CGFloat image_w_h = SearchResultViewLocationButtonImageSize;
    CGFloat image_y = (self_h - image_w_h)*0.5;
    
    return CGRectMake(image_x, image_y, image_w_h, image_w_h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat self_h = contentRect.size.height;
    CGFloat self_w = contentRect.size.width;
    
    CGFloat title_y = 0;
    CGFloat title_x = SearchResultViewLocationButtonImageMargin*2 + SearchResultViewLocationButtonImageSize;
    CGFloat title_h = self_h;
    CGFloat title_w = self_w - title_x;
    
    return CGRectMake(title_x, title_y, title_w, title_h);
}

- (void)setHighlighted:(BOOL)highlighted{}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat line_x = 0;
    CGFloat line_y = 0;
    CGFloat line_w = self.frame.size.width;
    CGFloat line_h = LINE_H;
    self.line.frame = CGRectMake(line_x, line_y, line_w, line_h);
}

@end
