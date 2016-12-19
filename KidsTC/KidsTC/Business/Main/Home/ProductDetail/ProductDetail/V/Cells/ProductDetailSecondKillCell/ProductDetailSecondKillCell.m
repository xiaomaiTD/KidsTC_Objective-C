//
//  ProductDetailSecondKillCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailSecondKillCell.h"
#import "NSString+Category.h"

@interface ProductDetailSecondKillCell ()
@property (weak, nonatomic) IBOutlet UILabel *priceIntegerL;
@property (weak, nonatomic) IBOutlet UILabel *smallNumberL;
@property (weak, nonatomic) IBOutlet UIView *secondKillTipBGView;
@property (weak, nonatomic) IBOutlet UILabel *secondKillTipL;
@property (weak, nonatomic) IBOutlet UIView *storePriceBGView;
@property (weak, nonatomic) IBOutlet UILabel *storePriceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storePriceLineH;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftTipL;
@property (weak, nonatomic) IBOutlet UILabel *hoursLeftL;
@property (weak, nonatomic) IBOutlet UILabel *minuteLeftL;
@property (weak, nonatomic) IBOutlet UILabel *secondLeftL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBGViewTraining;
@property (weak, nonatomic) IBOutlet UIView *daysBGView;
@property (weak, nonatomic) IBOutlet UILabel *daysLeftL;
@property (weak, nonatomic) IBOutlet UILabel *daysTipL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daysLeftLW;
@end

@implementation ProductDetailSecondKillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.secondKillTipBGView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.secondKillTipBGView.layer.borderWidth = LINE_H;
    self.storePriceLineH.constant = LINE_H;
    self.daysLeftL.layer.cornerRadius = 4;
    self.daysLeftL.layer.masksToBounds = YES;
    self.hoursLeftL.layer.cornerRadius = 4;
    self.hoursLeftL.layer.masksToBounds = YES;
    self.minuteLeftL.layer.cornerRadius = 4;
    self.minuteLeftL.layer.masksToBounds = YES;
    self.secondLeftL.layer.cornerRadius = 4;
    self.secondLeftL.layer.masksToBounds = YES;
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    CGFloat price = data.price.floatValue;
    NSString *priceStr = [NSString stringWithFormat:@"%0.2f",price];
    NSArray<NSString *> *prices = [priceStr componentsSeparatedByString:@"."];
    if (prices.count==2) {
        self.priceIntegerL.text = prices.firstObject;
        self.smallNumberL.text = [NSString stringWithFormat:@".%@",prices.lastObject];
    }
    self.secondKillTipL.text = data.priceSortName;
    self.storePriceL.text = [NSString stringWithFormat:@"¥%0.2f",data.originalPrice.floatValue];
    self.timeLeftTipL.text = data.countDown.countDownDesc;
    [self countDown];
}

- (void)countDown {
    ProductDetailCountDown *countDown = self.data.countDown;
    NSString *str = countDown.countDownValueString;
    if ([str isNotNull]) {
        self.leftBGViewTraining.constant = 120;
        self.daysLeftL.text = countDown.daysLeft;
        if ([countDown.daysLeft isNotNull]) {
            self.daysBGView.hidden = NO;
            self.daysLeftLW.constant = 18;
        }else{
            self.daysBGView.hidden = YES;
            self.daysLeftLW.constant = 0;
        }
        self.daysTipL.text = countDown.daysLeft.floatValue>0?@"天":nil;
        self.hoursLeftL.text = countDown.hoursLeft;
        self.minuteLeftL.text = countDown.minuteLeft;
        self.secondLeftL.text = countDown.secondLeft;
    }else{
        self.leftBGViewTraining.constant = 0;
        if (countDown.showCountDown && !countDown.countDownOver) {
            countDown.countDownOver = YES;
            if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
                [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeCountDownOver value:self.data];
            }
        }
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

@end
