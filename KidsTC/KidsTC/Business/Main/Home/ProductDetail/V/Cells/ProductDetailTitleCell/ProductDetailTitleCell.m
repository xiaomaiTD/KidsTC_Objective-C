//
//  ProductDetailTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTitleCell.h"

@interface ProductDetailTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation ProductDetailTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
}

- (void)setText:(NSString *)text {
    _text = text;
    self.titleL.text = text;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

@end
