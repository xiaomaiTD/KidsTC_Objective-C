//
//  WholesaleOrderDetailDateCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailDateCell.h"

@interface WholesaleOrderDetailDateCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@end

@implementation WholesaleOrderDetailDateCell

- (void)setData:(WholesaleOrderDetailData *)data {
    [super setData:data];
    self.timeL.text = data.time.time;
}

@end
