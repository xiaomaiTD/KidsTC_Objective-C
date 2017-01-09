//
//  RadishOrderDetailPayTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailPayTipCell.h"

@interface RadishOrderDetailPayTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;

@end

@implementation RadishOrderDetailPayTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(RadishOrderDetailData *)data {
    [super setData:data];
    self.tipL.text = data.expireTimeDesc;
}

@end
