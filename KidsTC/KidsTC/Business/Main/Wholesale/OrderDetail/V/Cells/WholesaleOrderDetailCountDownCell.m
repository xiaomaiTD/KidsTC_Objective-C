//
//  WholesaleOrderDetailCountDownCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailCountDownCell.h"
#import "NSString+Category.h"

@interface WholesaleOrderDetailCountDownCell ()
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *countDownView;
@property (weak, nonatomic) IBOutlet UIView *dayView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dayViewW;
@property (weak, nonatomic) IBOutlet UILabel *dayL;
@property (weak, nonatomic) IBOutlet UILabel *hourL;
@property (weak, nonatomic) IBOutlet UILabel *minuteL;
@property (weak, nonatomic) IBOutlet UILabel *secondL;
@property (weak, nonatomic) IBOutlet UILabel *daysTipL;

@property (weak, nonatomic) IBOutlet UIView *doneView;
@end

@implementation WholesaleOrderDetailCountDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.countDownView.layer.cornerRadius = 4;
    self.countDownView.layer.masksToBounds = YES;
    
    self.dayL.layer.cornerRadius = 2;
    self.dayL.layer.masksToBounds = YES;
    self.hourL.layer.cornerRadius = 2;
    self.hourL.layer.masksToBounds = YES;
    self.minuteL.layer.cornerRadius = 2;
    self.minuteL.layer.masksToBounds = YES;
    self.secondL.layer.cornerRadius = 2;
    self.secondL.layer.masksToBounds = YES;
    
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setData:(WholesaleOrderDetailData *)data {
    [super setData:data];
    [self countDown];
}

- (void)countDown {
    WholesaleOrderDetailCountDown *countDown = self.data.countDown;
    NSString *str = countDown.countDownValueString;
    if ([str isNotNull]) {
        self.countDownView.hidden = NO;
        self.doneView.hidden = YES;
        self.dayL.text = countDown.daysLeft;
        if ([countDown.daysLeft isNotNull]) {
            self.dayView.hidden = NO;
            self.dayViewW.constant = 36;
        }else{
            self.dayView.hidden = YES;
            self.dayViewW.constant = 0;
        }
        self.daysTipL.text = countDown.daysLeft.floatValue>0?@"天":nil;
        self.hourL.text = countDown.hoursLeft;
        self.minuteL.text = countDown.minuteLeft;
        self.secondL.text = countDown.secondLeft;
    }else{
        self.countDownView.hidden = YES;
        self.doneView.hidden = NO;
        [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
        if (countDown.showCountDown && !countDown.countDownOver) {
            countDown.countDownOver = YES;
            
        }
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}
@end
