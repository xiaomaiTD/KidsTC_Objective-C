//
//  ServiceOrderDetailCountDownCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceOrderDetailCountDownCell.h"
#import "YYTimer.h"

@interface ServiceOrderDetailCountDownCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) YYTimer *timer;
@end

@implementation ServiceOrderDetailCountDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(countDown) repeats:YES];
}

- (void)setData:(ServiceOrderDetailData *)data {
    [super setData:data];
    [self countDown];
}

- (void)countDown{
    self.titleLabel.attributedText = [self checkValite]?self.data.countDownValueString:nil;
}

- (BOOL)checkValite{
    if (self.data.remainingTime<0) {
        if ([self.delegate respondsToSelector:@selector(serviceOrderDetailBaseCell:actionType:)]) {
            [self.delegate serviceOrderDetailBaseCell:self actionType:ServiceOrderDetailBaseCellActionTypeReload];
        }
        if (self.timer) [self.timer invalidate];
        return NO;
    }
    return YES;
}

@end
