//
//  SearchFactorFilterView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterView.h"
#import "NSString+Category.h"

#import "SearchFactorFilterAgeView.h"
#import "SearchFactorFilterCategoryView.h"
#import "SearchFactorFilterToolBar.h"

@interface SearchFactorFilterView ()<SearchFactorFilterToolBarDelegate>
@property (strong, nonatomic) SearchFactorFilterAgeView *ageView;
@property (strong, nonatomic) SearchFactorFilterCategoryView *categoryView;
@property (strong, nonatomic) SearchFactorFilterToolBar *toolBar;
@end

@implementation SearchFactorFilterView

- (SearchFactorFilterAgeView *)ageView {
    if (!_ageView) {
        _ageView = [self viewWithNib:@"SearchFactorFilterAgeView"];
        [self addSubview:_ageView];
    }
    return _ageView;
}

- (SearchFactorFilterCategoryView *)categoryView {
    if (!_categoryView) {
        _categoryView = [self viewWithNib:@"SearchFactorFilterCategoryView"];
        [self addSubview:_categoryView];
    }
    return _categoryView;
}

- (SearchFactorFilterToolBar *)toolBar {
    if (!_toolBar) {
        _toolBar = [self viewWithNib:@"SearchFactorFilterToolBar"];
        _toolBar.delegate = self;
        [self addSubview:_toolBar];
    }
    return _toolBar;
}

- (id)viewWithNib:(NSString *)nib {
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    self.ageView.frame = CGRectMake(0, 0, self_w, self.ageView.contentHeight);
    self.categoryView.frame = CGRectMake(0, CGRectGetMaxY(self.ageView.frame) + 10, self_w, self.categoryView.contentHeight);
    self.toolBar.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self_w, kSearchFactorFilterToolBarH);
}

- (CGFloat)contentHeight {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGFloat height = CGRectGetMaxY(self.toolBar.frame);
    return height;
}

- (void)setInsetParam:(NSDictionary *)insetParam {
    _insetParam = insetParam;
    self.ageView.insetParam = _insetParam;
    self.categoryView.insetParam = _insetParam;
    [self setupSelectedByClick:NO];
}

- (void)reset {
    [self.ageView reset];
    [self.categoryView reset];
}


#pragma mark - SearchFactorFilterToolBarDelegate

- (void)searchFactorFilterToolBar:(SearchFactorFilterToolBar *)toolBar
                       actionType:(SearchFactorFilterToolBarActionType)type
                            value:(id)value
{
    switch (type) {
        case SearchFactorFilterToolBarActionTypeClean:
        {
            [self.ageView clean];
            [self.categoryView clean];
        }
            break;
        case SearchFactorFilterToolBarActionTypeSure:
        {
            [self.ageView sure];
            [self.categoryView sure];
            
            [self setupSelectedByClick:YES];
        }
            break;
    }
}

- (void)setupSelectedByClick:(BOOL)byClick {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    SearchFactorFilterAgeItem *ageItem = self.ageView.cellSelectedItem;
    NSString *age = @"";
    if (ageItem.dataSelected) {
        age = [NSString stringWithFormat:@"%@",ageItem.value];
    }
    [dic setObject:age forKey:kSearchKey_age];
    
    SearchFactorFilterCategoryItemRight *categoryItemRight = self.categoryView.cellSelectedItemRight;
    NSString *category = @"";
    if (categoryItemRight.dataSelected) {
        category = categoryItemRight.value;
    }
    [dic setObject:category forKey:kSearchKey_category];
    
    if ([self.delegate respondsToSelector:@selector(searchFactorFilterView:didSelectParam:byClick:)]) {
        [self.delegate searchFactorFilterView:self didSelectParam:[NSDictionary dictionaryWithDictionary:dic] byClick:byClick];
    }
}


@end
