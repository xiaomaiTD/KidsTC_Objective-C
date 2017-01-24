//
//  ScoreCenterItemsCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreCenterItemsCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface ScoreCenterItemsCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation ScoreCenterItemsCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorFromHexString:@"dedede"].CGColor;
    self.layer.borderWidth = 1;
}

@end
