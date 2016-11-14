//
//  ProductDetaiFreeToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetaiFreeToolBar.h"

@interface ProductDetaiFreeToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

@end

@implementation ProductDetaiFreeToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.applyBtn.backgroundColor = COLOR_PINK;
    self.likeBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarLike;
    self.shareBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarShare;
    self.applyBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarApply;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseToolBar:actionType:value:)]) {
        [self.delegate productDetailBaseToolBar:self actionType:sender.tag value:nil];
    }
}


@end
