//
//  ProductOrderListAllTitleCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListAllTitleCollectionCell.h"
#import "Colours.h"
@interface ProductOrderListAllTitleCollectionCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ProductOrderListAllTitleCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.borderWidth = LINE_H;
}

- (void)setItem:(ProductOrderListAllTitleRowItem *)item {
    _item = item;
    [self.btn setTitle:_item.title forState:UIControlStateNormal];
    self.btn.selected = item.selected;
    self.btn.layer.borderColor = item.selected?COLOR_PINK.CGColor:[UIColor clearColor].CGColor;
    self.btn.backgroundColor = item.selected?[UIColor clearColor]:[UIColor colorFromHexString:@"F2F2F2"];
}

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(_item);
    }
}

@end
