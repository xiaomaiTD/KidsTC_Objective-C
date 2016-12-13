//
//  ProductOrderTicketDetailTimeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailTimeCell.h"

@interface ProductOrderTicketDetailTimeCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductOrderTicketDetailTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(ProductOrderTicketDetailData *)data {
    [super setData:data];
    self.timeL.text = data.showTime;
}

@end
