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
    self.contentView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = view;
}

- (void)setItem:(SearchFactorFilterDataItemLefe *)item {
    _item = item;
    self.titleL.text = _item.title;
    self.tipView.hidden = !_item.selected;
}

@end
