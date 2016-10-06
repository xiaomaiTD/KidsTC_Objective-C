//
//  SearchTableTextField.m
//  KidsTC
//
//  Created by 詹平 on 16/6/29.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import "SearchTableTextField.h"
#import "Macro.h"

#define SearchTableTextFieldButtonImageSize 10
#define SearchTableTextFieldButtonImageRightMargin 4
@interface SearchTableTextFieldButton : UIButton

@end

@implementation SearchTableTextFieldButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self setImage:[UIImage imageNamed:@"arrow_down_white"] forState:UIControlStateNormal];
    }
    return self;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat self_h = contentRect.size.height;
    CGFloat self_w = contentRect.size.width;
    CGFloat title_w = self_w - SearchTableTextFieldButtonImageSize-SearchTableTextFieldButtonImageRightMargin;
    return CGRectMake(0, 0, title_w, self_h);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat self_h = contentRect.size.height;
    CGFloat self_w = contentRect.size.width;
    CGFloat image_x = self_w-SearchTableTextFieldButtonImageSize-SearchTableTextFieldButtonImageRightMargin;
    CGFloat image_y = (self_h-SearchTableTextFieldButtonImageSize)*0.5;
    CGFloat image_w_h = SearchTableTextFieldButtonImageSize;
    return CGRectMake(image_x, image_y, image_w_h, image_w_h);
}

- (void)setHighlighted:(BOOL)highlighted{}

@end

@interface SearchTableTextField ()
@property (nonatomic, strong) UIButton *searchTypeBtn;
@end

@implementation SearchTableTextField

- (UIButton *)searchTypeBtn{
    if (!_searchTypeBtn) {
        SearchTableTextFieldButton *searchTypeBtn = [SearchTableTextFieldButton buttonWithType:UIButtonTypeCustom];
        [searchTypeBtn setFrame:CGRectMake(0, 0, 54, 30)];
        [searchTypeBtn addTarget:self action:@selector(didClickedSearchTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        _searchTypeBtn = searchTypeBtn;
    }
    return _searchTypeBtn;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(255,0,0,0.2);
        self.textColor = [UIColor whiteColor];
        
        self.font = [UIFont systemFontOfSize:15];
        
        self.leftView = self.searchTypeBtn;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.returnKeyType = UIReturnKeySearch;
        
        self.borderStyle = UITextBorderStyleNone;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4;
        
    }
    return self;
}

- (void)setSearchTypeItem:(SearchTypeItem *)searchTypeItem{
    _searchTypeItem = searchTypeItem;
    self.placeholder = searchTypeItem.placeHolder;
    [self.searchTypeBtn setTitle:searchTypeItem.searchTypeTitle forState:UIControlStateNormal];
}


- (void)didClickedSearchTypeBtn:(SearchTableTextFieldButton *)btn{
    if (self.didClickOnSearchTypeBtn) {
        self.didClickOnSearchTypeBtn();
    }
}

@end
