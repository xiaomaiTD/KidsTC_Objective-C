//
//  ProductDetailAddressAnnoView.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailAddressAnnoView.h"

@interface ProductDetailAddressAnnoView ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ProductDetailAddressAnnoView

- (void)setStore:(ProductDetailStore *)store {
    _store = store;
    self.label.text = store.location.moreDescription;
}


- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailAddressAnnoView:actionType:value:)]) {
        [self.delegate productDetailAddressAnnoView:self actionType:ProductDetailAddressAnnoViewActionTypeGoto value:self.store];
    }
}
@end
