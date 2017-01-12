//
//  SeckillToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillToolBar.h"
#import "SeckillToolBarItem.h"

CGFloat const kSeckillToolBarH = 49;

@interface SeckillToolBar ()<SeckillToolBarItemDelegate>
@property (nonatomic, strong) NSArray<SeckillToolBarItem *> *toolBarItems;
@end

@implementation SeckillToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    if (self.toolBarItems.count>0) {
        CGFloat item_w = self_w/self.toolBarItems.count;
        [self.toolBarItems enumerateObjectsUsingBlock:^(SeckillToolBarItem *obj, NSUInteger idx, BOOL *stop) {
            obj.frame = CGRectMake(item_w * idx, 0, item_w, self_h);
        }];
    }
}

- (void)setTimeData:(SeckillTimeData *)timeData {
    _timeData = timeData;
    self.hidden = timeData==nil;
    NSMutableArray *ary = [NSMutableArray array];
    [timeData.toolBarItems enumerateObjectsUsingBlock:^(SeckillTimeToolBarItem *obj, NSUInteger idx, BOOL *stop) {
        SeckillToolBarItem *toolBarItem =  [self itemWithItem:obj];
        [self addSubview:toolBarItem];
        if (toolBarItem) [ary addObject:toolBarItem];
    }];
    self.toolBarItems = [NSArray arrayWithArray:ary];
}

- (SeckillToolBarItem *)itemWithItem:(SeckillTimeToolBarItem *)item {
    SeckillToolBarItem *toolBarItem = [[NSBundle mainBundle] loadNibNamed:@"SeckillToolBarItem" owner:self options:nil].firstObject;
    toolBarItem.delegate = self;
    toolBarItem.item = item;
    return toolBarItem;
}

- (void)setDataData:(SeckillDataData *)dataData {
    _dataData = dataData;
}

#pragma mark - SeckillToolBarItemDelegate

- (void)didClickSeckillToolBarItem:(SeckillToolBarItem *)item {
    if ([self.delegate respondsToSelector:@selector(seckillToolBar:actionType:value:)]) {
        [self.delegate seckillToolBar:self actionType:item.item.type value:nil];
    }
}

@end
