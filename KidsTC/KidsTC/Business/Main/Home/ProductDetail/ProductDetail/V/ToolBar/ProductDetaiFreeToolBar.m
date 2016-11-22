//
//  ProductDetaiFreeToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetaiFreeToolBar.h"
#import "User.h"

@interface ProductDetaiFreeToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineOneH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineTwoH;

@end

@implementation ProductDetaiFreeToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.likeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.shareBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.HLineOneH.constant = LINE_H;
    self.HLineTwoH.constant = LINE_H;
    self.applyBtn.backgroundColor = COLOR_PINK;
    self.likeBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarLike;
    self.shareBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarShare;
    self.applyBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarApply;
    [self layoutIfNeeded];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.likeBtn.selected = data.isFavor;
    self.applyBtn.enabled = data.isCanBuy;
    [self.applyBtn setTitle:data.statusDesc forState:UIControlStateNormal];
}

- (IBAction)action:(UIButton *)sender {
    ProductDetailBaseToolBarActionType type = (ProductDetailBaseToolBarActionType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(productDetailBaseToolBar:actionType:value:)]) {
        [self.delegate productDetailBaseToolBar:self actionType:type value:nil];
        if (type == ProductDetailBaseToolBarActionTypeFreeToolBarLike) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                self.data.isFavor = !self.data.isFavor;
                self.likeBtn.selected = self.data.isFavor;
            }];
        }
    }
}


@end
