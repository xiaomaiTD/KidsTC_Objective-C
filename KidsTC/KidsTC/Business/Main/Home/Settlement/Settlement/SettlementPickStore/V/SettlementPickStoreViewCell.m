//
//  SettlementPickStoreViewCell.m
//  KidsTC
//
//  Created by zhanping on 8/12/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SettlementPickStoreViewCell.h"
#import "FiveStarsView.h"

@interface SettlementPickStoreViewCell ()
@property (weak, nonatomic) IBOutlet UIView *shapeView;
@property (weak, nonatomic) IBOutlet UIView *itemsContentsView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *pickStoreDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;

@end

@implementation SettlementPickStoreViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.starsView.userInteractionEnabled = NO;
    self.shapeView.layer.cornerRadius = 4;
    self.shapeView.layer.masksToBounds = YES;
    self.shapeView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.shapeView.layer.borderWidth = LINE_H;
}

- (void)setItem:(SettlementPickStoreDataItem *)item{
    _item = item;
    
    self.nameLabel.text = item.storeName;
    self.starsView.starNumber = item.level;
    self.pickStoreDescLabel.attributedText = item.pickStoreDesc;
    self.checkImageView.hidden = !item.selected;
    self.shapeView.layer.borderColor = ([item.selected?COLOR_PINK:[UIColor lightGrayColor] colorWithAlphaComponent:0.3]).CGColor;
}

@end
