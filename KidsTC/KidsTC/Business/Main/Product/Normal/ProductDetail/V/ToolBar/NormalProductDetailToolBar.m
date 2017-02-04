//
//  NormalProductDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailToolBar.h"
#import "User.h"
#import "NSString+Category.h"

CGFloat const kNormalProductDetailToolBarH = 77;

@interface NormalProductDetailToolBar ()
@property (weak, nonatomic) IBOutlet UIView *btnsBGView;
@property (weak, nonatomic) IBOutlet UIButton *consultBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UILabel *attentionL;
@property (weak, nonatomic) IBOutlet UIImageView *attentionImg;
@property (weak, nonatomic) IBOutlet UIButton *buyNowBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineH;
@property (weak, nonatomic) IBOutlet UIView *countDownBGView;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countDownLineH;
@end

@implementation NormalProductDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.HLineH.constant = LINE_H;
    self.VLineH.constant = LINE_H;
    self.countDownLineH.constant = LINE_H;
    [self layoutIfNeeded];
    
    self.consultBtn.tag = NormalProductDetailToolBarActionTypeConsult;
    self.attentionBtn.tag = NormalProductDetailToolBarActionTypeAttention;
    self.buyNowBtn.tag = NormalProductDetailToolBarActionTypeBuyNow;
    
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setData:(NormalProductDetailData *)data {
    _data = data;
    
    self.hidden = _data==nil;
    
    [self setupAttention];
    
    [self setupBuyBtn];
    
    [self countDown];
}

- (void)setupAttention {
    NSString *likeTitle = nil;
    NSString *likeImg = nil;
    if (_data.isFavor) {
        likeTitle = @"已关注";
        likeImg = @"ProductDetail_normalToolBar_love_y";
    }else{
        likeTitle = @"关注";
        likeImg = @"ProductDetail_normalToolBar_love_n";
    }
    self.attentionL.text = likeTitle;
    self.attentionImg.image = [UIImage imageNamed:likeImg];
}

- (void)setupBuyBtn {
    self.buyNowBtn.enabled = _data.isCanBuy;
    [self.buyNowBtn setTitle:_data.statusDesc forState:UIControlStateNormal];
    self.buyNowBtn.backgroundColor = _data.isCanBuy?[UIColor colorFromHexString:@"ff8888"]:[UIColor lightGrayColor];
}

- (void)countDown {
    NormalProductDetailCountDown *countDown = _data.countDown;
    NSString *str = countDown.countDownValueString;
    if ([str isNotNull] && (_data.priceSort != PriceSortSecKill)) {
        _countDownBGView.hidden = NO;
        _countDownL.text = str;
    }else{
        _countDownBGView.hidden = YES;
        //[NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
        if (countDown.showCountDown && !countDown.countDownOver) {
            countDown.countDownOver = YES;
            if ([self.delegate respondsToSelector:@selector(normalProductDetailToolBar:actionType:value:)]) {
                [self.delegate normalProductDetailToolBar:self actionType:NormalProductDetailToolBarActionTypeCountDownOver value:nil];
            }
        }
    }
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

- (IBAction)action:(UIButton *)sender {
    NormalProductDetailToolBarActionType type = (NormalProductDetailToolBarActionType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(normalProductDetailToolBar:actionType:value:)]) {
        if (type == NormalProductDetailToolBarActionTypeAttention) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                [self.delegate normalProductDetailToolBar:self actionType:type value:nil];
                self.data.isFavor = !self.data.isFavor;
                [self setupAttention];
            }];
        }else{
            [self.delegate normalProductDetailToolBar:self actionType:type value:nil];
        }
    }
}

@end
