//
//  SearchFactorFilterRightCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterRightCell.h"

@interface SearchFactorFilterRightCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;
@end

@implementation SearchFactorFilterRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setItem:(SearchFactorFilterDataItemRight *)item {
    _item = item;
    self.titleL.text = _item.title;
    NSString *imgName = _item.selected?@"serviceSettlement_select_yes":@"serviceSettlement_select_no";
    self.checkImg.image = [UIImage imageNamed:imgName];
}


@end
