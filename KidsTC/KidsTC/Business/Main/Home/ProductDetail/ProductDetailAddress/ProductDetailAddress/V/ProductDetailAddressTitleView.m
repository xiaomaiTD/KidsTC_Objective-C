//
//  ProductDetailAddressTitleView.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailAddressTitleView.h"

@interface ProductDetailAddressTitleView ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@property (nonatomic, weak) UIButton *currentBtn;
@end

@implementation ProductDetailAddressTitleView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    [_btns enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx + 1;
    }];
}

- (IBAction)action:(UIButton *)sender {
    self.currentBtn.selected = NO;
    sender.selected = YES;
    self.currentBtn = sender;
    if ([self.delegate respondsToSelector:@selector(productDetailAddressTitleView:actionType:value:)]) {
        [self.delegate productDetailAddressTitleView:self actionType:sender.tag value:nil];
    }
}


@end
