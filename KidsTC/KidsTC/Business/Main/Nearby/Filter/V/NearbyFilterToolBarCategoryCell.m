//
//  NearbyFilterToolBarCategoryCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyFilterToolBarCategoryCell.h"
#import "Colours.h"

@interface NearbyFilterToolBarCategoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation NearbyFilterToolBarCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(NearbyFilterToolBarCategoryItem *)item {
    _item = item;
    self.titleL.text = _item.title;
    self.titleL.textColor = _item.selected?COLOR_PINK:[UIColor colorFromHexString:@"555555"];
}

@end
