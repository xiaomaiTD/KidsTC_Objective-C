//
//  WolesaleProductDetailTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailTitleCell.h"

@interface WolesaleProductDetailTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation WolesaleProductDetailTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = _title;
}

@end
