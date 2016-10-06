//
//  FDChooseStoreCell.m
//  KidsTC
//
//  Created by zhanping on 5/21/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FDChooseStoreCell.h"
#import "FiveStarsView.h"

@interface FDChooseStoreCell ()
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet FiveStarsView *soreView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) FDStoreItem *storeItem;
@end

@implementation FDChooseStoreCell

- (void)awakeFromNib{
    [super awakeFromNib];
    UIView *selectedBGView = [[UIView alloc]init];
    selectedBGView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.selectedBackgroundView = selectedBGView;
}

- (void)configWithSotre:(FDStoreItem *)store isSelected:(BOOL)isSelected{
    self.storeNameLabel.text = store.storeName;
    self.storeNameLabel.textColor = isSelected?COLOR_PINK:[UIColor lightGrayColor];
    [self.soreView setStarNumber:store.level];
    self.distanceLabel.text = store.distance;
}

@end
