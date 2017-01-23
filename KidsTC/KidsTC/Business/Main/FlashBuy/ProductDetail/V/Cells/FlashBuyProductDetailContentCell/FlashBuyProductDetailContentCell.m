//
//  FlashBuyProductDetailContentCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailContentCell.h"

@interface FlashBuyProductDetailContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentL;

@end

@implementation FlashBuyProductDetailContentCell


- (void)setData:(FlashBuyProductDetailData *)data {
    [super setData:data];
    self.contentL.attributedText = data.attContent;
}



@end
