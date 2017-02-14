//
//  ScoreEarnMemberTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreEarnMemberTipCell.h"

@interface ScoreEarnMemberTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation ScoreEarnMemberTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(ScoreEarnShowItem *)item {
    [super setItem:item];
    self.titleL.text = item.title;
}


@end
