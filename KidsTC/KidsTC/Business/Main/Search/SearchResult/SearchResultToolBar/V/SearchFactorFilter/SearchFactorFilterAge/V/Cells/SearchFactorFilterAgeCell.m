//
//  SearchFactorFilterAgeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterAgeCell.h"
#import "Colours.h"

@interface SearchFactorFilterAgeCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *selImg;
@end

@implementation SearchFactorFilterAgeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderWidth = LINE_H;
}

- (void)setItem:(SearchFactorFilterAgeItem *)item {
    _item = item;
    
    self.titleL.text = _item.title;
    
    if (_item.cellSelected) {
        self.titleL.textColor = COLOR_PINK;
        self.selImg.hidden = NO;
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.bgView.layer.borderColor = COLOR_PINK.CGColor;
    }else{
        self.titleL.textColor = [UIColor colorFromHexString:@"5B5B5B"];
        self.selImg.hidden = YES;
        self.bgView.backgroundColor = [UIColor colorFromHexString:@"F2F2F2"];
        self.bgView.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

@end
