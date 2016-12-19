//
//  ProductDetaiFreeToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetaiFreeToolBar.h"
#import "User.h"
#import "UIButton+Category.h"
#import "ProductDetailToolBarButton.h"

@interface ProductDetaiFreeToolBar ()
@property (weak, nonatomic) IBOutlet UIView *freeBGView;
@property (weak, nonatomic) IBOutlet ProductDetailToolBarButton *likeBtn;
@property (weak, nonatomic) IBOutlet ProductDetailToolBarButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineOneH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineOneW;

@property (weak, nonatomic) IBOutlet UIView *lotteryBGView;
@property (weak, nonatomic) IBOutlet ProductDetailToolBarButton *lotteryShareBtn;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBuyBtn;
@property (weak, nonatomic) IBOutlet UIButton *lotteryApplyBtn;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineTwoH;

@end

@implementation ProductDetaiFreeToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineOneH.constant = LINE_H;
    self.VLineOneW.constant = LINE_H;
    self.HLineTwoH.constant = LINE_H;
    
    [self.applyBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.applyBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    self.likeBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarLike;
    self.shareBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarShare;
    self.applyBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarApply;
    
    [self.lotteryApplyBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.lotteryApplyBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    self.lotteryShareBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarShare;
    self.lotteryApplyBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarApply;
    self.lotteryBuyBtn.tag = ProductDetailBaseToolBarActionTypeFreeToolBarRelateBuy;
    
    [self layoutIfNeeded];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    if (data.relatedProduct) {
        self.freeBGView.hidden = YES;
        self.lotteryBGView.hidden = NO;
        self.lotteryApplyBtn.enabled = data.isCanBuy;
        [self.lotteryApplyBtn setTitle:data.statusDesc forState:UIControlStateNormal];
        self.buyPriceL.text = data.relatedProduct.price;
    }else{
        self.freeBGView.hidden = NO;
        self.lotteryBGView.hidden = YES;
        self.likeBtn.selected = data.isFavor;
        NSString *likeTitle = data.isFavor?@"取消关注":@"关注";
        [self.likeBtn setTitle:likeTitle forState:UIControlStateNormal];
        self.applyBtn.enabled = data.isCanBuy;
        [self.applyBtn setTitle:data.statusDesc forState:UIControlStateNormal];
    }
}

- (IBAction)action:(UIButton *)sender {
    ProductDetailBaseToolBarActionType type = (ProductDetailBaseToolBarActionType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(productDetailBaseToolBar:actionType:value:)]) {
        [self.delegate productDetailBaseToolBar:self actionType:type value:nil];
        if (type == ProductDetailBaseToolBarActionTypeFreeToolBarLike) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                self.data.isFavor = !self.data.isFavor;
                self.likeBtn.selected = self.data.isFavor;
                NSString *likeTitle = self.data.isFavor?@"取消关注":@"关注";
                [self.likeBtn setTitle:likeTitle forState:UIControlStateNormal];
            }];
        }
    }
}


@end
