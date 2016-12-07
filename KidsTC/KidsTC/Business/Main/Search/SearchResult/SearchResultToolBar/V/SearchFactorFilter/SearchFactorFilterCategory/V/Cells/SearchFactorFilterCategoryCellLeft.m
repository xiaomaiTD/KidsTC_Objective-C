//
//  SearchFactorFilterCategoryCellLeft.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterCategoryCellLeft.h"
#import "UIImageView+WebCache.h"
#import "Colours.h"

@interface SearchFactorFilterCategoryCellLeft ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *selImg;
@end

@implementation SearchFactorFilterCategoryCellLeft

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(SearchFactorFilterCategoryItemLeft *)item {
    _item = item;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_item.icon] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.titleL.text = _item.title;
    self.contentView.backgroundColor = _item.currentCell?[UIColor whiteColor]:[UIColor colorFromHexString:@"F7F7F7"];
    self.selImg.hidden = !_item.cellSelected;
}

@end
