//
//  ServiceOrderDetailPayTipCell.m
//  KidsTC
//
//  Created by zhanping on 8/18/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailPayTipCell.h"

@interface ServiceOrderDetailPayTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *payTipLabel;

@end

@implementation ServiceOrderDetailPayTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.payTipLabel.textColor = COLOR_YELL;
}

- (void)setData:(ServiceOrderDetailData *)data{
    [super setData:data];
    self.payTipLabel.text = data.expireTimeDesc;
}

@end
