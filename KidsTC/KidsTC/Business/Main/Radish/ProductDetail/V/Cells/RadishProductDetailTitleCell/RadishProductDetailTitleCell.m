//
//  RadishProductDetailTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailTitleCell.h"

@interface RadishProductDetailTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation RadishProductDetailTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleL.textColor = [UIColor colorFromHexString:@"222222"];
}

- (void)setData:(RadishProductDetailData *)data {
    [super setData:data];
    
}

- (void)setText:(NSString *)text {
    _text = text;
    self.titleL.text = text;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

@end
