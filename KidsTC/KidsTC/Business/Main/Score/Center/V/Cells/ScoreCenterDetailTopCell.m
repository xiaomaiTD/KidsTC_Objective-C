//
//  ScoreCenterDetailTopCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreCenterDetailTopCell.h"

@interface ScoreCenterDetailTopCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation ScoreCenterDetailTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}


@end
