//
//  ProductDetailTicketSelectSeatCollectionViewTimeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatCollectionViewTimeCell.h"
#import "UIButton+Category.h"
#import "Colours.h"
#import "YYKit.h"
#import "NSString+Category.h"

@interface ProductDetailTicketSelectSeatCollectionViewTimeCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *weakL;
@end

@implementation ProductDetailTicketSelectSeatCollectionViewTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.borderColor = [UIColor colorFromHexString:@"dedede"].CGColor;
    self.bgView.layer.borderWidth = 1;
}

- (void)setTime:(ProductDetailTicketSelectSeatTime *)time {
    _time = time;
    
    self.timeL.text = _time.date;
    
    NSMutableString *twoStr = [NSMutableString string];
    if ([_time.dayOfWeek isNotNull]) {
        [twoStr appendString:_time.dayOfWeek];
    }
    if ([_time.minuteTime isNotNull]) {
        [twoStr appendString:[NSString stringWithFormat:@" %@",_time.minuteTime]];
    }
    self.weakL.text = twoStr;
    
    self.userInteractionEnabled = _time.seats.count>0;
    if (self.userInteractionEnabled) {
        if (_time.selected) {
            self.bgView.layer.borderColor = [UIColor colorFromHexString:@"FF8888"].CGColor;
            self.bgView.backgroundColor = [UIColor whiteColor];
            self.timeL.textColor = [UIColor colorFromHexString:@"FF8888"];
            self.weakL.textColor = [UIColor colorFromHexString:@"FF8888"];
        }else{
            self.bgView.layer.borderColor = [UIColor colorFromHexString:@"DEDEDE"].CGColor;
            self.bgView.backgroundColor = [UIColor whiteColor];
            self.timeL.textColor = [UIColor colorFromHexString:@"555555"];
            self.weakL.textColor = [UIColor colorFromHexString:@"555555"];
        }
    }else{
        self.bgView.layer.borderColor = [UIColor clearColor].CGColor;
        self.bgView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
        self.timeL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
        self.weakL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
    }
}

@end
