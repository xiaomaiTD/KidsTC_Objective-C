//
//  ActivityProductCouponsFooter.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/14.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductCouponsFooter.h"

@interface ActivityProductCouponsFooter ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;

@end

@implementation ActivityProductCouponsFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setContent:(ActivityProductContent *)content {
    _content = content;
    self.tipL.text = content.couponTips;
}

@end
