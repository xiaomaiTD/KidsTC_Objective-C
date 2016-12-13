//
//  ProductOrderTicketDetailPayInfoTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailPayInfoTitleCell.h"

@interface ProductOrderTicketDetailPayInfoTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *payTypeL;
@property (weak, nonatomic) IBOutlet UILabel *getTicketL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageH;
@end

@implementation ProductOrderTicketDetailPayInfoTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
    self.imageH.constant = LINE_H;
}

- (void)setData:(ProductOrderTicketDetailData *)data {
    [super setData:data];
    self.payTypeL.text = data.payTypeDesc;
    self.getTicketL.text = data.takeTicketWayDesc;
}

@end
