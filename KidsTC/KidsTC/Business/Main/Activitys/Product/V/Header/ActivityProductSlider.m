//
//  ActivityProductSlider.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductSlider.h"
#import "ActivityProductSliderItem.h"

CGFloat const kActivityProductSliderH = 34;

static CGFloat const item_margin = 0;

@interface ActivityProductSlider ()<ActivityProductSliderItemDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray<ActivityProductSliderItem *> *items;
@property (nonatomic, strong) ActivityProductSliderItem *selectedItem;
@end

@implementation ActivityProductSlider

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
}

- (void)setContent:(ActivityProductContent *)content {
    _content = content;
    
    NSArray<ActivityProductTabItem *> *tabItems = content.tabItems;
    
    self.hidden = tabItems.count<1;
    
    if (self.items.count>0) {
        [self.items makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.items = nil;
    }
    
    UIColor *tabBgc = [UIColor colorFromHexString:content.tabBgc];
    UIColor *tabSelBgc = [UIColor colorFromHexString:content.tabSelBgc];
    UIColor *tabFontCor = [UIColor colorFromHexString:content.tabFontCor];
    UIColor *tabSelFontCor = [UIColor colorFromHexString:content.tabSelFontCor];
    UIColor *tabSelIndexCor = [UIColor colorFromHexString:content.tabSelIndexCor];
    
    self.backgroundColor = tabBgc;
    self.contentView.backgroundColor = tabBgc;
    self.scrollView.backgroundColor = tabBgc;
    
    NSMutableArray *ary = [NSMutableArray array];
    __block ActivityProductSliderItem *lastItem = nil;
    [tabItems enumerateObjectsUsingBlock:^(ActivityProductTabItem *obj, NSUInteger idx, BOOL *stop) {
        ActivityProductSliderItem *item = [[NSBundle mainBundle] loadNibNamed:@"ActivityProductSliderItem" owner:self options:nil].firstObject;
        item.index = idx;
        item.delegate = self;
        item.tabBgc = tabBgc;
        item.tabSelBgc = tabSelBgc;
        item.tabFontCor = tabFontCor;
        item.tabSelFontCor = tabSelFontCor;
        item.tabSelIndexCor = tabSelIndexCor;
        item.item = obj;
        item.selected = NO;
        CGFloat item_w = [obj.tabName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width + 30;
        item.frame = CGRectMake(CGRectGetMaxX(lastItem.frame) + item_margin, 0, item_w, kActivityProductSliderH);
        [self.scrollView addSubview:item];
        lastItem = item;
        if (item)[ary addObject:item];
    }];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastItem.frame), kActivityProductSliderH);
    self.items = [NSArray arrayWithArray:ary];
}

- (void)selectIndex:(NSUInteger)index toSelect:(BOOL)toSelect {
    self.selectedItem.selected = NO;
    if (index<self.items.count && toSelect) {
        ActivityProductSliderItem *item = self.items[index];
        item.selected = toSelect;
        self.selectedItem = item;
    }
}


#pragma mark - ActivityProductSliderItemDelegate

- (void)didClickActivityProductSliderItem:(ActivityProductSliderItem *)item {
    if ([self.delegate respondsToSelector:@selector(activityProductSlider:didSelectItem:index:)]) {
        [self.delegate activityProductSlider:self didSelectItem:item.item index:item.index];
    }
}


@end
