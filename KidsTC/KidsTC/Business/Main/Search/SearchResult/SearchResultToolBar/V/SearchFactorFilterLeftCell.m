//
//  SearchFactorFilterLeftCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterLeftCell.h"
#import "Colours.h"

@interface SearchFactorFilterLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@end

@implementation SearchFactorFilterLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tipView.layer.cornerRadius = CGRectGetWidth(self.tipView.frame) * 0.5;
    self.tipView.layer.masksToBounds = YES;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor *backgroundColor = self.tipView.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    self.tipView.backgroundColor = backgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    UIColor *backgroundColor = self.tipView.backgroundColor;
    [super setSelected:selected animated:animated];
    self.tipView.backgroundColor = backgroundColor;
}

- (void)setItem:(SearchFactorFilterDataItemLefe *)item {
    _item = item;
    self.titleL.text = _item.title;
    self.tipView.hidden = !_item.selected;
    UIColor *bgColor = _item.cellSeleted?[UIColor whiteColor]:[UIColor colorFromHexString:@"F7F7F7"];
    self.contentView.backgroundColor = bgColor;
}

@end
