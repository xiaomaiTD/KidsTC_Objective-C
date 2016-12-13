//
//  ProductOrderNormalDetailPayTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailPayTipCell.h"

@interface ProductOrderNormalDetailPayTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;

@end

@implementation ProductOrderNormalDetailPayTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
    self.tipL.text = data.expireTimeDesc;
}

@end
