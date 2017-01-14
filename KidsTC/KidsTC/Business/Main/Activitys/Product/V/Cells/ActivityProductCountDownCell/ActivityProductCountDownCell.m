//
//  ActivityProductCountDownCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ActivityProductCountDownCell.h"
#import "NSString+Category.h"

@interface ActivityProductCountDownCell ()

@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *countDownView;
@property (weak, nonatomic) IBOutlet UILabel *countDownTipL;

@property (weak, nonatomic) IBOutlet UIView *dayView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dayViewW;
@property (weak, nonatomic) IBOutlet UILabel *dayL;
@property (weak, nonatomic) IBOutlet UILabel *dayTipL;
@property (weak, nonatomic) IBOutlet UILabel *hourL;
@property (weak, nonatomic) IBOutlet UILabel *hourTipL;
@property (weak, nonatomic) IBOutlet UILabel *minuteL;
@property (weak, nonatomic) IBOutlet UILabel *minuteTipL;
@property (weak, nonatomic) IBOutlet UILabel *secondL;
@property (weak, nonatomic) IBOutlet UILabel *secondTipL;
@property (weak, nonatomic) IBOutlet UIView *firstDot;
@property (weak, nonatomic) IBOutlet UIView *secondDot;

@property (nonatomic, strong) ActivityProductContent *content;

@end

@implementation ActivityProductCountDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    //self.countDownView.layer.cornerRadius = 4;
    //self.countDownView.layer.masksToBounds = YES;
    
    self.dayL.layer.cornerRadius = 2;
    self.dayL.layer.masksToBounds = YES;
    self.hourL.layer.cornerRadius = 2;
    self.hourL.layer.masksToBounds = YES;
    self.minuteL.layer.cornerRadius = 2;
    self.minuteL.layer.masksToBounds = YES;
    self.secondL.layer.cornerRadius = 2;
    self.secondL.layer.masksToBounds = YES;
    
    self.firstDot.layer.cornerRadius = CGRectGetWidth(self.firstDot.bounds)*0.5;
    self.firstDot.layer.masksToBounds = YES;
    self.secondDot.layer.cornerRadius = CGRectGetWidth(self.secondDot.bounds)*0.5;
    self.secondDot.layer.masksToBounds = YES;
    
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setFloorItem:(ActivityProductFloorItem *)floorItem {
    [super setFloorItem:floorItem];
    NSArray<ActivityProductContent *> *contents = floorItem.contents;
    if (contents.count>0) {
        ActivityProductContent *content = contents.firstObject;
        self.content = content;
        self.countDownTipL.text = content.countDownText;
        [self setupColor];
        [self countDown];
    }
}

- (void)setupColor {
    
    ActivityProductContent *content = self.content;
    
    UIColor *bgColor = [UIColor colorFromHexString:content.floorBgc];
    self.contentView.backgroundColor = bgColor;
    self.countDownView.backgroundColor = bgColor;
    self.dayL.textColor = bgColor;
    self.hourL.textColor = bgColor;
    self.minuteL.textColor = bgColor;
    self.secondL.textColor = bgColor;
    
    UIColor *fontColor = [UIColor colorFromHexString:content.fontColor];
    self.line.backgroundColor = fontColor;
    self.firstDot.backgroundColor = fontColor;
    self.secondDot.backgroundColor = fontColor;
    self.countDownTipL.textColor = fontColor;
    self.dayL.backgroundColor = fontColor;
    self.hourL.backgroundColor = fontColor;
    self.minuteL.backgroundColor = fontColor;
    self.secondL.backgroundColor = fontColor;
    self.dayTipL.textColor = fontColor;
    self.hourTipL.textColor = fontColor;
    self.minuteTipL.textColor = fontColor;
    self.secondTipL.textColor = fontColor;
}

- (void)countDown {
    ActivityProductContent *content = self.content;
    NSString *str = content.countDownValueString;
    if ([str isNotNull] && !content.countDownOver) {
        if ([content.daysLeft isNotNull]) {
            self.dayView.hidden = NO;
            self.dayViewW.constant = 40;
            self.dayL.text = content.daysLeft;
        }else{
            self.dayView.hidden = YES;
            self.dayViewW.constant = 0;
        }
        self.hourL.text = content.hoursLeft;
        self.minuteL.text = content.minuteLeft;
        self.secondL.text = content.secondLeft;
    }else{
        if (content.isShowCountDown && !content.countDownOver) {
            content.countDownOver = YES;
            [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
        }
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

@end
