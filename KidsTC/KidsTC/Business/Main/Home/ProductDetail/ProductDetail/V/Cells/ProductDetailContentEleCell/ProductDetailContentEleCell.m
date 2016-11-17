//
//  ProductDetailContentEleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailContentEleCell.h"

@interface ProductDetailContentEleCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *valueL;

@end

@implementation ProductDetailContentEleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
}

- (void)setNotice:(ProductDetailNotice *)notice {
    _notice = notice;
    self.tipL.text = notice.clause;
    self.valueL.attributedText = notice.attNotice;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

@end
