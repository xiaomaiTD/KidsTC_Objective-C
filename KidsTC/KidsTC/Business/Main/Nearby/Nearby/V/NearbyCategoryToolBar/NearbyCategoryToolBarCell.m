//
//  NearbyCategoryToolBarCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCategoryToolBarCell.h"
#import "Colours.h"

@interface NearbyCategoryToolBarCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation NearbyCategoryToolBarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(NearbyCategoryToolBarItem *)item {
    _item = item;
    self.titleL.text = _item.title;
    self.titleL.textColor = _item.selected?COLOR_PINK:[UIColor colorFromHexString:@"555555"];
}

@end
