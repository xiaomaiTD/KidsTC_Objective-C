//
//  NormalProductDetailContentEleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailContentEleCell.h"

@interface NormalProductDetailContentEleCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *valueL;

@end

@implementation NormalProductDetailContentEleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
}

- (void)setNotice:(NormalProductDetailNotice *)notice {
    _notice = notice;
    self.tipL.text = notice.clause;
    self.valueL.attributedText = notice.attNotice;
}

@end
