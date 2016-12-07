//
//  SearchFactorFilterCategoryCellRight.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterCategoryCellRight.h"
#import "Colours.h"

@interface SearchFactorFilterCategoryCellRight ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *selImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HlineH;
@end

@implementation SearchFactorFilterCategoryCellRight

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HlineH.constant = LINE_H;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(SearchFactorFilterCategoryItemRight *)item {
    _item = item;
    self.titleL.text = _item.title;
    if (_item.cellSelected) {
        self.selImg.image = [UIImage imageNamed:@"search_toolBar_filter_sel"];
        self.titleL.textColor = COLOR_PINK;
    }else{
        self.selImg.image = [UIImage imageNamed:@"search_toolBar_filter_unsel"];
        self.titleL.textColor = [UIColor colorFromHexString:@"5B5B5B"];
    }
}
@end
