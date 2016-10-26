//
//  ProductDetailDateCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailDateCell.h"

@interface ProductDetailDateCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateL;

@end

@implementation ProductDetailDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.dateL.text = data.time.desc;
}
- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

@end
