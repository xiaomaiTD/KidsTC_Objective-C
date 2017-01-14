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

- (void)setContent:(ActivityProductContent *)content {
    _content = content;
    
    NSArray<ActivityProductTabItem *> *tabItems = content.tabItems;
    
    self.hidden = tabItems.count<1;
    
    if (self.toolBarItems.count>0) {
        [self.toolBarItems makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.toolBarItems = nil;
    }
    
    NSMutableArray *ary = [NSMutableArray array];
    __block ActivityProductToolBarItem *lastToolBarItem = nil;
    CGFloat item_h = CGRectGetHeight(self.bounds);
    [tabItems enumerateObjectsUsingBlock:^(ActivityProductTabItem *obj, NSUInteger idx, BOOL *stop) {
        ActivityProductToolBarItem *toolBarItem =  [self itemWithItem:obj];
        toolBarItem.index = idx;
        CGFloat item_w = SCREEN_WIDTH * obj.tabWidthRate;
        toolBarItem.frame = CGRectMake(CGRectGetMaxX(lastToolBarItem.frame), 0, item_w, item_h);
        [self addSubview:toolBarItem];
        if (toolBarItem) [ary addObject:toolBarItem];
        lastToolBarItem = toolBarItem;
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
    ActivityProductTabItem *itemData = item.item;
    if ([self.delegate respondsToSelector:@selector(activityProductToolBar:actionType:value:)]) {
        [self.delegate activityProductToolBar:self actionType:ActivityProductToolBarActionTypeSegue value:itemData.segueModel];
    }
}

@end
