//
//  RadishProductDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailToolBar.h"
#import "UIButton+Category.h"
#import "User.h"
#import "NSString+Category.h"

CGFloat const kRadishProductDetailToolBarH = 77;

@interface RadishProductDetailToolBar ()

@property (weak, nonatomic) IBOutlet UIView *countDownView;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countDownLineH;

@property (weak, nonatomic) IBOutlet UIView *btnsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsHLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsVLineH;
@property (weak, nonatomic) IBOutlet UIButton *consultBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIImageView *attentionImg;
@property (weak, nonatomic) IBOutlet UILabel *attentionL;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@end

@implementation RadishProductDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.countDownLineH.constant = LINE_H;
    self.btnsHLineH.constant = LINE_H;
    self.btnsVLineH.constant = LINE_H;
    
    self.consultBtn.tag = RadishProductDetailToolBarActionTypeToolBarConsult;
    self.attentionBtn.tag = RadishProductDetailToolBarActionTypeToolBarAttention;
    self.buyBtn.tag = RadishProductDetailToolBarActionTypeToolBarBuyNow;
    
    [self.buyBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.buyBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setData:(RadishProductDetailData *)data {
    _data = data;
    self.hidden = data==nil;
    self.buyBtn.enabled = data.isCanBuy;
    [self.buyBtn setTitle:data.statusDesc forState:UIControlStateNormal];
    [self setupAttentionBtn];
}

- (IBAction)action:(UIButton *)sender {
    RadishProductDetailToolBarActionType type = (RadishProductDetailToolBarActionType)sender.tag;

    if ([self.delegate respondsToSelector:@selector(radishProductDetailToolBar:actionType:value:)]) {
        [self.delegate radishProductDetailToolBar:self actionType:sender.tag value:_data];
        if (type == RadishProductDetailToolBarActionTypeToolBarAttention) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                self.data.isFavor = !self.data.isFavor;
                [self setupAttentionBtn];
            }];
        }
    }
}

- (void)setupAttentionBtn {
    self.attentionImg.image = [UIImage imageNamed:self.data.isFavor?@"ProductDetail_normalToolBar_love_y":@"ProductDetail_normalToolBar_love_n"];
    self.attentionL.text = self.data.isFavor?@"已关注":@"关注";
}

- (void)countDown {
    RadishProductDetailCountDown *countDown = self.data.countDown;
    
    NSString *str = countDown.countDownValueString;
    if ([str isNotNull]) {
        _countDownView.hidden = NO;
        _countDownL.text = str;
    }else{
        _countDownView.hidden = YES;
        [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
        if (countDown.showCountDown && !countDown.countDownOver) {
            countDown.countDownOver = YES;
            if ([self.delegate respondsToSelector:@selector(radishProductDetailToolBar:actionType:value:)]) {
                [self.delegate radishProductDetailToolBar:self actionType:RadishProductDetailToolBarActionTypeToolBarCountDonwFinished value:_data];
                
            }
        }
    }
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

@end
