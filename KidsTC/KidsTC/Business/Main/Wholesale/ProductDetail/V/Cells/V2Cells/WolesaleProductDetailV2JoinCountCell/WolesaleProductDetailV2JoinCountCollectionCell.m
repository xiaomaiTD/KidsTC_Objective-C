//
//  WolesaleProductDetailV2JoinCountCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailV2JoinCountCollectionCell.h"
#import "UIButton+Category.h"

@interface WolesaleProductDetailV2JoinCountCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation WolesaleProductDetailV2JoinCountCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleL.layer.cornerRadius = 4;
    self.titleL.layer.masksToBounds = YES;
    self.titleL.layer.borderWidth = 1;
}

- (void)setItem:(WholesaleProductDetailCount *)item {
    _item = item;
    self.titleL.text = _item.title;
    
    UIColor *titleColor = [UIColor colorFromHexString:@"999999"];
    UIColor *backgroundColor = [UIColor whiteColor];
    UIColor *borderColor = [UIColor colorFromHexString:@"999999"];
    if (_item.selected) {
        titleColor = [UIColor whiteColor];
        backgroundColor = [UIColor colorFromHexString:@"F36863"];
        borderColor = [UIColor clearColor];
        
    }
    self.titleL.textColor = titleColor;
    self.titleL.backgroundColor = backgroundColor;
    self.titleL.layer.borderColor = borderColor.CGColor;
}

@end
