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

static CGFloat const item_margin = 24;

@interface ActivityProductSlider ()<ActivityProductSliderItemDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray<ActivityProductSliderItem *> *items;
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
    
    NSMutableArray *ary = [NSMutableArray array];
    __block ActivityProductSliderItem *lastItem = nil;
    [tabItems enumerateObjectsUsingBlock:^(ActivityProductTabItem *obj, NSUInteger idx, BOOL *stop) {
        ActivityProductSliderItem *item = [[NSBundle mainBundle] loadNibNamed:@"ActivityProductSliderItem" owner:self options:nil].firstObject;
        item.item = obj;
        item.index = idx;
        item.delegate = self;
        CGFloat item_w = [obj.tabName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
        item.frame = CGRectMake(CGRectGetMaxX(lastItem.frame) + item_margin, 0, item_w, kActivityProductSliderH);
        [self.scrollView addSubview:item];
        lastItem = item;
        [ary addObject:item];
    }];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastItem.frame), kActivityProductSliderH);
    self.items = [NSArray arrayWithArray:ary];
}


#pragma mark - ActivityProductSliderItemDelegate

- (void)didClickActivityProductSliderItem:(ActivityProductSliderItem *)item {
    if ([self.delegate respondsToSelector:@selector(activityProductSlider:didSelectItem:index:)]) {
        [self.delegate activityProductSlider:self didSelectItem:item.item index:item.index];
    }
}


@end
