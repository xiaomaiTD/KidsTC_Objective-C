//
//  RadishProductDetailApplyCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailApplyCell.h"

@interface RadishProductDetailApplyCell ()
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation RadishProductDetailApplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tipView.layer.cornerRadius = 2;
    self.tipView.layer.masksToBounds = YES;
}

- (void)setAttStr:(NSAttributedString *)attStr {
    _attStr = attStr;
    self.titleL.attributedText = attStr;
}

@end
