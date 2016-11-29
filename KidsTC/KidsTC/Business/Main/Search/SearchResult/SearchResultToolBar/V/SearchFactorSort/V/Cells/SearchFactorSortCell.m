//
//  SearchFactorSortCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorSortCell.h"

@interface SearchFactorSortCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;
@end

@implementation SearchFactorSortCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(SearchFactorSortDataItem *)item {
    _item = item;
    self.img.image = [UIImage imageNamed:_item.img];
    self.title.text = _item.title;
    self.checkImg.hidden = !_item.selected;
}

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(_item);
    }
}


@end
