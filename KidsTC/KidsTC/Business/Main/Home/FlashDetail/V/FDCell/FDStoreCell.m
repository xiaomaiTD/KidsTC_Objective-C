//
//  FDStoreCell.m
//  KidsTC
//
//  Created by zhanping on 5/19/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FDStoreCell.h"
#import "FiveStarsView.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"
@interface FDStoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@end

@implementation FDStoreCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5];
    self.selectedBackgroundView = bgView;
    
    self.distanceLabel.textColor = COLOR_BLUE;
}

- (void)setStoreItem:(FDStoreItem *)storeItem{
    _storeItem = storeItem;
    [self.storeImageView sd_setImageWithURL:[NSURL URLWithString:storeItem.imgUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    
    self.storeNameLabel.text = storeItem.storeName;
    
    self.distanceLabel.text = storeItem.distance;
    
    [self.starsView setStarNumber:storeItem.level];
}

@end
