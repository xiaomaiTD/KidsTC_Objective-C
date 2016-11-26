//
//  CouponListUnusedCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListUnusedCell.h"

@interface CouponListUnusedCell ()
@property (weak, nonatomic) IBOutlet UIButton *useBtn;
@property (weak, nonatomic) IBOutlet UIImageView *expiredIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation CouponListUnusedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.useBtn.layer.cornerRadius = CGRectGetHeight(self.useBtn.frame) * 0.5;
    self.useBtn.layer.masksToBounds = YES;
    
}

- (IBAction)action:(UIButton *)sender {
    
}


@end
