//
//  ProductDetailFreeApplyActivityDateCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyActivityDateCell.h"

@interface ProductDetailFreeApplyActivityDateCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *dateL;

@end

@implementation ProductDetailFreeApplyActivityDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.dateL.text = data.time.desc;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyBaseCell:actionType:value:)]) {
        [self.delegate productDetailFreeApplyBaseCell:self actionType:ProductDetailFreeApplyBaseCellActionTypeActivityDate value:nil];
    }
}


@end
