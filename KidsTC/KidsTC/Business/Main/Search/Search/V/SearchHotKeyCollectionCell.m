//
//  SearchHotKeyCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchHotKeyCollectionCell.h"

@interface SearchHotKeyCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation SearchHotKeyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setItem:(SearchHotKeywordsItem *)item {
    _item = item;
    self.titleL.text = item.name;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if (self.actionBlock) {
        self.actionBlock(_item);
    }
}

@end
