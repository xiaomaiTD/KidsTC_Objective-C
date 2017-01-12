//
//  SeckillOtherLeftCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillOtherLeftCell.h"

@interface SeckillOtherLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation SeckillOtherLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(SeckillOtherItem *)item {
    _item = item;
    self.titleL.text = item.name;
    if (item.selected) {
        self.titleL.textColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor colorFromHexString:@"fe5f5c"];
    }else{
        self.titleL.textColor = [UIColor colorFromHexString:@"444444"];
        self.contentView.backgroundColor = [UIColor colorFromHexString:@"f7f7f7"];
    }
}

@end
