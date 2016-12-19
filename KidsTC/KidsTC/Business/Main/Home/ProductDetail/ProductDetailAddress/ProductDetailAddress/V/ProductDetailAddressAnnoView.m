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

- (void)setPlace:(ProductDetailAddressSelStoreModel *)place {
    _place = place;
    self.label.text = _place.location.moreDescription;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailAddressAnnoView:actionType:value:)]) {
        [self.delegate productDetailAddressAnnoView:self actionType:ProductDetailAddressAnnoViewActionTypeGoto value:_place];
    }
}
@end
