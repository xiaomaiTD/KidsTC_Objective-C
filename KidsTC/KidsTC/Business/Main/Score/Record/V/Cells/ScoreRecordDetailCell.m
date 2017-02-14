//
//  ScoreRecordDetailCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreRecordDetailCell.h"

@interface ScoreRecordDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *scoreL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ScoreRecordDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.HLineH.constant = LINE_H;
}

- (void)setRecord:(ScoreRecordItem *)record {
    _record = record;
    self.titleL.text = [NSString stringWithFormat:@"%@（%@）",record.type,record.desc];
    self.timeL.text = record.time;
    self.scoreL.text = record.num;
}

@end
