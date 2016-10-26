//
//  ProductDetailBaseCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailBaseCell.h"

@implementation ProductDetailBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
    
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

@end
