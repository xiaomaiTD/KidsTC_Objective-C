//
//  ScoreConsumeTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreConsumeTipCell.h"

@interface ScoreConsumeTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation ScoreConsumeTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(ScoreConsumeShowItem *)item {
    [super setItem:item];
    self.titleL.text = item.title;
}


@end
