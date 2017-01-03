//
//  ProductStandardCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductStandardCell.h"
#import "Colours.h"

@interface ProductStandardCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductStandardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.HLineH.constant = LINE_H;
}

- (void)setStandard:(ProductDetailStandard *)standard {
    _standard = standard;
    self.nameL.text = standard.standardName;
    self.nameL.textColor = _standard.selected?COLOR_PINK:[UIColor colorFromHexString:@"222222"];
}

@end
