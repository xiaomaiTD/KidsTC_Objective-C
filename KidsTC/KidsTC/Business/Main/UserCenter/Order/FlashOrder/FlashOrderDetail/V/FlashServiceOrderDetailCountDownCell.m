//
//  FlashServiceOrderDetailCountDownCell.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderDetailCountDownCell.h"
#import "YYTimer.h"

@interface FlashServiceOrderDetailCountDownCell ()
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (nonatomic, strong) YYTimer *timer;
@end

@implementation FlashServiceOrderDetailCountDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(countDown) repeats:YES];
}

- (void)setData:(FlashServiceOrderDetailData *)data{
    [super setData:data];
    [self countDown];
}

- (void)countDown{
    self.countDownLabel.attributedText = [self checkValite]?self.data.countDownValueString:nil;
}

- (BOOL)checkValite{
    if (self.data.countDownValue<0) {
        if ([self.delegate respondsToSelector:@selector(flashServiceOrderDetailBaseCell:actionType:)] && self.data.countDownValueOriginal>0) {
            [self.delegate flashServiceOrderDetailBaseCell:self actionType:FlashServiceOrderDetailBaseCellActionTypeReload];
        }
        if (self.timer) [self.timer invalidate];
        return NO;
    }
    return YES;
}

@end
