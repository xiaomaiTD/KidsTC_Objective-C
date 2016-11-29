//
//  SearchFactorAreaHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorAreaHeader.h"

@interface SearchFactorAreaHeader ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;
@end

@implementation SearchFactorAreaHeader

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setItem:(SearchFactorAreaDataItem *)item {
    _item = item;
    self.titleL.text = _item.title;
    self.checkImg.hidden = !_item.selected;
}

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(_item);
    }
}
@end
