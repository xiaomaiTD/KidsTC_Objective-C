//
//  WolesaleProductDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailToolBar.h"
#import "NSString+Category.h"

CGFloat const kWolesaleProductDetailToolBarH = 77;

@interface WolesaleProductDetailToolBar ()
@property (weak, nonatomic) IBOutlet UIView *shareBGView;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareLineH;


@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;

@property (weak, nonatomic) IBOutlet UIView *countDownView;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countDownLineH;

@end

@implementation WolesaleProductDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.shareLineH.constant = LINE_H;
    self.joinBtn.backgroundColor = [UIColor colorFromHexString:@"FF9C9C"];
    self.saleBtn.backgroundColor = [UIColor colorFromHexString:@"F36863"];
    
    self.countDownLineH.constant = LINE_H;
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
    
    self.shareBtn.tag = WolesaleProductDetailToolBarActionTypeShare;
    self.joinBtn.tag = WolesaleProductDetailToolBarActionTypeJoin;
    
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailToolBar:actionType:value:)]) {
        [self.delegate wolesaleProductDetailToolBar:self actionType:sender.tag value:nil];
    }
}

- (void)setData:(WolesaleProductDetailData *)data {
    _data = data;
    WholesaleProductDetailBase *base = data.fightGroupBase;
    self.hidden = base == nil;
    
    NSString *saleTitle = nil;
    if (_data.openGroupSysNo>0) {
        saleTitle = @"我的拼团";
        self.saleBtn.tag = WolesaleProductDetailToolBarActionTypeMySale;
    }else{
        saleTitle = @"我要组团";
        self.saleBtn.tag = WolesaleProductDetailToolBarActionTypeSale;
    }
    [self.saleBtn setTitle:saleTitle forState:UIControlStateNormal];
    [self countDown];
}

- (void)countDown {
    WholesaleProductDetailCountDown *countDown = self.data.fightGroupBase.countDown;
    
    NSString *str = countDown.countDownValueString;
    if ([str isNotNull]) {
        _countDownView.hidden = NO;
        _countDownL.text = str;
    }else{
        _countDownView.hidden = YES;
        //[NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
        if (countDown.showCountDown && !countDown.countDownOver) {
            countDown.countDownOver = YES;
            if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailToolBar:actionType:value:)]) {
                [self.delegate wolesaleProductDetailToolBar:self actionType:WolesaleProductDetailToolBarActionTypeCountDownOver value:nil];
            }
        }
    }
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}


@end
