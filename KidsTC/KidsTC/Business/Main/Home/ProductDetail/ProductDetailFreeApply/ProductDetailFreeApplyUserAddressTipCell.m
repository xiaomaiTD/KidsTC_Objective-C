//
//  ProductDetailFreeApplyUserAddressTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyUserAddressTipCell.h"

@interface ProductDetailFreeApplyUserAddressTipCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ProductDetailFreeApplyUserAddressTipCell


- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyBaseCell:actionType:value:)]) {
        [self.delegate productDetailFreeApplyBaseCell:self actionType:ProductDetailFreeApplyBaseCellActionTypeUserAddressTip value:nil];
    }
}


@end
