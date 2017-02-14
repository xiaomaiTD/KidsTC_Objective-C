//
//  ScoreCenterItemsCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreCenterItemsCell.h"

@interface ScoreCenterItemsCell ()
@property (weak, nonatomic) IBOutlet UIButton *getBtn;
@property (weak, nonatomic) IBOutlet UIButton *useBtn;
@end

@implementation ScoreCenterItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.getBtn.tag = ScoreCenterBaseCellActionTypeGet;
    self.useBtn.tag = ScoreCenterBaseCellActionTypeUse;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(scoreCenterBaseCell:actionType:vlaue:)]) {
        [self.delegate scoreCenterBaseCell:self actionType:(ScoreCenterBaseCellActionType)sender.tag vlaue:nil];
    }
}

@end
