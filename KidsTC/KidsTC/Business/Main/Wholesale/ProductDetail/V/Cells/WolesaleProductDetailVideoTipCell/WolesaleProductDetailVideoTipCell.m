//
//  WolesaleProductDetailVideoTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailVideoTipCell.h"

@interface WolesaleProductDetailVideoTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation WolesaleProductDetailVideoTipCell

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = title;
}

@end
