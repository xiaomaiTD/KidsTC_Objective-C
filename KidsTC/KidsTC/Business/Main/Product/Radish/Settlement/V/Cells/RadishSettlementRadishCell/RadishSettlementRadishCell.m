//
//  RadishSettlementRadishCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishSettlementRadishCell.h"

@interface RadishSettlementRadishCell ()
@property (weak, nonatomic) IBOutlet UILabel *totalCountL;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@end

@implementation RadishSettlementRadishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(RadishSettlementData *)data {
    [super setData:data];
    self.countL.text = [NSString stringWithFormat:@"%@根",data.radishCount];
    self.totalCountL.text = [NSString stringWithFormat:@"共计%@个萝卜",data.totalRadishCount];
}

@end
