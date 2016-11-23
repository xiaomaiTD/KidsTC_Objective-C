//
//  ProductDetailFreeApplyFooterView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyFooterView.h"

@interface ProductDetailFreeApplyFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation ProductDetailFreeApplyFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
}

- (IBAction)action:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock();
    }
}


@end
