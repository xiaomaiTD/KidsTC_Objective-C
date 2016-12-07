//
//  SearchResultProductLargeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultProductLargeCell.h"

@interface SearchResultProductLargeCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerIcon;
@property (weak, nonatomic) IBOutlet UIImageView *storeIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *stateL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerH;
@end

@implementation SearchResultProductLargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    
    self.priceL.textColor = COLOR_PINK;
    self.storeIcon.layer.cornerRadius = CGRectGetWidth(self.storeIcon.bounds) * 0.5;
    self.storeIcon.layer.masksToBounds = YES;
    self.storeIcon.layer.borderWidth = 1;
    self.storeIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}


@end
