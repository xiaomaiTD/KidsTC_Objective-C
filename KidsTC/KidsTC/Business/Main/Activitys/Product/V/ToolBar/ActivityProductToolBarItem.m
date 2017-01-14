//
//  ActivityProductToolBarItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductToolBarItem.h"
#import "UIImageView+WebCache.h"

@interface ActivityProductToolBarItem ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation ActivityProductToolBarItem

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setItem:(ActivityProductTabItem *)item {
    _item = item;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.tabPicUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickActivityProductToolBarItem:)]) {
        [self.delegate didClickActivityProductToolBarItem:self];
    }
}

@end
