//
//  SearchHistoryCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchHistoryCell.h"

@interface SearchHistoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation SearchHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setRowItem:(SearchRowItem *)rowItem {
    _rowItem = rowItem;
    NSArray<SearchHotKeywordsItem *> *items = _rowItem.items;
    if (items.count>0) {
        SearchHotKeywordsItem *item = items.firstObject;
        self.titleL.text = item.name;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    NSArray<SearchHotKeywordsItem *> *items = _rowItem.items;
    if (items.count>0) {
        SearchHotKeywordsItem *item = items.firstObject;
        if (self.actionBlock) {
            self.actionBlock(item);
        }
    }
}

@end
