//
//  TCStoreDetailNearbyPackageTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailNearbyPackageTitleCell.h"

@interface TCStoreDetailNearbyPackageTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HlineH;
@end

@implementation TCStoreDetailNearbyPackageTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HlineH.constant = LINE_H;
}

@end
