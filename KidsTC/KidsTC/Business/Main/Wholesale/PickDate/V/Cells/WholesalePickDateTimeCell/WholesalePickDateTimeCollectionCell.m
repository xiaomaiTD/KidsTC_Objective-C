//
//  WholesalePickDateTimeCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesalePickDateTimeCollectionCell.h"
#import "YYKit.h"

@interface WholesalePickDateTimeCollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *tipImg;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (nonatomic, assign) BOOL select;

@end

@implementation WholesalePickDateTimeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setTime:(WholesalePickDateTime *)time {
    _time = time;
    self.timeL.attributedText = time.attTimeStr;
    self.select = time.select;
}


- (void)setSelect:(BOOL)select {
    _select = select;
    
    if (self.select) {
        self.bgView.layer.borderColor = [UIColor colorFromHexString:@"ff8888"].CGColor;
        self.bgView.layer.borderWidth = 1;
        self.tipImg.hidden = NO;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.timeL.attributedText];
        str.color = [UIColor colorFromHexString:@"ff8888"];
        self.timeL.attributedText = [[NSAttributedString alloc] initWithAttributedString:str];
    }else{
        self.bgView.layer.borderColor = [UIColor colorFromHexString:@"e5e5e5"].CGColor;
        self.bgView.layer.borderWidth = 1;
        self.tipImg.hidden = YES;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.timeL.attributedText];
        str.color = [UIColor colorFromHexString:@"555555"];
        self.timeL.attributedText = [[NSAttributedString alloc] initWithAttributedString:str];
    }
}

@end
