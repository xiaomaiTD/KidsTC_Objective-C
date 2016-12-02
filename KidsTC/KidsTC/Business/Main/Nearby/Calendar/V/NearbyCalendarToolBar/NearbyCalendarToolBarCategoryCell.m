//
//  NearbyCalendarToolBarCategoryCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCalendarToolBarCategoryCell.h"
#import "Colours.h"

@interface NearbyCalendarToolBarCategoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation NearbyCalendarToolBarCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(NearbyCalendarToolBarCategoryItem *)item {
    _item = item;
    self.titleL.text = _item.title;
    self.titleL.textColor = _item.selected?COLOR_PINK:[UIColor colorFromHexString:@"555555"];
}

@end
