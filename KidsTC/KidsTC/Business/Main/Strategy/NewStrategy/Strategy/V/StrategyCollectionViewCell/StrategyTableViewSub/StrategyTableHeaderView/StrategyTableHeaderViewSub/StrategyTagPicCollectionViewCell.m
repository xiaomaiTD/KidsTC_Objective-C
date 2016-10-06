//
//  StrategyTagPicCollectionViewCell.m
//  KidsTC
//
//  Created by zhanping on 6/12/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyTagPicCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface StrategyTagPicCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation StrategyTagPicCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = LINE_H;
}
- (void)setItem:(StrategyTypeListTagPicItem *)item{
    _item = item;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:nil];
}
@end
