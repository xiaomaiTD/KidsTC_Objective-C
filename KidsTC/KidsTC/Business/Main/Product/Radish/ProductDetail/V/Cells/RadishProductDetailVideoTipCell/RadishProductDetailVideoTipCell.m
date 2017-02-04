//
//  RadishProductDetailVideoTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailVideoTipCell.h"

@interface RadishProductDetailVideoTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation RadishProductDetailVideoTipCell

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = title;
}

@end
