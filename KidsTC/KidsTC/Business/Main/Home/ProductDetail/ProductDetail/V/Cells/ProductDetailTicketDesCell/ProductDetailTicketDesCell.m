//
//  ProductDetailTicketDesCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketDesCell.h"


@interface ProductDetailTicketDesCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@end

@implementation ProductDetailTicketDesCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize maxSize = CGSizeMake(SCREEN_WIDTH - 30, 99999);
    CGFloat h = [self.contentL.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    CGFloat constH = 16;
    
    if (!self.data.synopsisOpen) {
        if (h>60) {
            h = h*0.5;
        }
    }
    h = h + constH;
    return CGSizeMake(size.width, h);
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
    self.contentL.attributedText = data.attSynopsis;
}

@end
