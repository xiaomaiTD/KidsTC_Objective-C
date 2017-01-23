//
//  FlashBuyProductDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailToolBar.h"
#import "NSString+Category.h"

CGFloat const kFlashBuyProductDetailToolBarH = 77;

@interface FlashBuyProductDetailToolBar ()
@property (weak, nonatomic) IBOutlet UIView *btnsBGView;
@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineH;
@property (weak, nonatomic) IBOutlet UIView *countDownBGView;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countDownLineH;
@end

@implementation FlashBuyProductDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
    self.VLineH.constant = LINE_H;
    self.countDownLineH.constant = LINE_H;
    [self layoutIfNeeded];
    
    self.inviteBtn.tag = FlashBuyProductDetailToolBarActionTypeInvite;
    self.buyBtn.tag = FlashBuyProductDetailToolBarActionTypeOriginalPriceBuy;
    self.statusBtn.tag = FlashBuyProductDetailToolBarActionTypeStatus;
    
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailToolBar:actionType:value:)]) {
        [self.delegate flashBuyProductDetailToolBar:self actionType:(FlashBuyProductDetailToolBarActionType)sender.tag value:_data.segueModel];
    }
}


- (void)setData:(FlashBuyProductDetailData *)data {
    _data = data;
    self.hidden = data==nil;
    [self setupStatusBtn];
    [self countDown];
}

- (void)setupStatusBtn {
    BOOL isCanBuy = self.data.isLink;
    FlashBuyProductDetailStatus status = self.data.status;
    NSString *statusDesc = self.data.statusDesc;
    UIColor *statusColor = nil;
    if (!isCanBuy) {//是否可以点击
        switch (status) {
            case FlashBuyProductDetailStatusNotStart://= 1,//闪购尚未开始，未到预约时间
            {
                statusColor = [UIColor colorWithRed:0.200  green:0.766  blue:0.494 alpha:1];
                self.statusBtn.enabled = !self.data.isOpenRemind;
                statusDesc = self.data.isOpenRemind?@"已提醒":@"开闪提醒";
            }
                break;
            default:
            {
                statusColor = [UIColor lightGrayColor];
                self.statusBtn.enabled = NO;
            }
                break;
        }
    }else{//按钮可以点击
        self.statusBtn.enabled = YES;
        switch (status) {
            case FlashBuyProductDetailStatusWaitBuy://= 4,//等待开团，等待开团（已预付）:
            case FlashBuyProductDetailStatusHadPaid://= 12,//闪购成功，已购买:
            case FlashBuyProductDetailStatusEvaluted://= 16,//已评价，已评价 -在订单中:
            {
                statusColor = [COLOR_PINK colorWithAlphaComponent:0.5];
            }
                break;
            default:
            {
                statusColor = COLOR_PINK;
            }
                break;
        }
    }
    [self.statusBtn setTitle:statusDesc forState:UIControlStateNormal];
    self.statusBtn.backgroundColor = statusColor;
}

- (void)countDown {
    NSString *str = self.data.countDownValueString;
    if ([str isNotNull]) {
        _countDownBGView.hidden = NO;
        _countDownL.text = str;
    }else{
        _countDownBGView.hidden = YES;
        //[NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
        if (self.data.isShowCountDown && !self.data.countDownOver) {
            self.data.countDownOver = YES;
            if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailToolBar:actionType:value:)]) {
                [self.delegate flashBuyProductDetailToolBar:self actionType:FlashBuyProductDetailToolBarActionTypeCountDownOver value:nil];
            }
        }
    }
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

@end
