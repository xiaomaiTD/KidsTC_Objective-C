//
//  ActivityProductToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductToolBar.h"
#import "ActivityProductToolBarItem.h"

CGFloat const kActivityProductToolBarH = 49;

@interface ActivityProductToolBar ()<ActivityProductToolBarItemDelegate>
@property (nonatomic, strong) NSArray<ActivityProductToolBarItem *> *toolBarItems;
@end

@implementation ActivityProductToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    if (self.toolBarItems.count>0) {
        CGFloat item_w = self_w/self.toolBarItems.count;
        [self.toolBarItems enumerateObjectsUsingBlock:^(ActivityProductToolBarItem *obj, NSUInteger idx, BOOL *stop) {
            obj.frame = CGRectMake(item_w * idx, 0, item_w, self_h);
        }];
    }
}

- (void)setContent:(ActivityProductContent *)content {
    _content = content;
    
    NSArray<ActivityProductTabItem *> *tabItems = content.tabItems;
    
    self.hidden = tabItems.count<1;
    
    if (self.toolBarItems.count>0) {
        [self.toolBarItems makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.toolBarItems = nil;
    }
    
    NSMutableArray *ary = [NSMutableArray array];
    [tabItems enumerateObjectsUsingBlock:^(ActivityProductTabItem *obj, NSUInteger idx, BOOL *stop) {
        ActivityProductToolBarItem *toolBarItem =  [self itemWithItem:obj];
        toolBarItem.index = idx;
        [self addSubview:toolBarItem];
        if (toolBarItem) [ary addObject:toolBarItem];
    }];
    self.toolBarItems = [NSArray arrayWithArray:ary];
}

- (ActivityProductToolBarItem *)itemWithItem:(ActivityProductTabItem *)item {
    ActivityProductToolBarItem *toolBarItem = [[NSBundle mainBundle] loadNibNamed:@"ActivityProductToolBarItem" owner:self options:nil].firstObject;
    toolBarItem.delegate = self;
    toolBarItem.item = item;
    return toolBarItem;
}

#pragma mark - ActivityProductToolBarItemDelegate

- (void)didClickActivityProductToolBarItem:(ActivityProductToolBarItem *)item {
    if ([self.delegate respondsToSelector:@selector(activityProductToolBar:didSelectItem:index:)]) {
        [self.delegate activityProductToolBar:self didSelectItem:item.item index:item.index];
    }
}

@end
