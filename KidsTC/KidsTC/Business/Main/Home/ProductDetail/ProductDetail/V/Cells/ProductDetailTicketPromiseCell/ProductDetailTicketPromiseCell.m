//
//  ProductDetailTicketPromiseCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketPromiseCell.h"

@interface ProductDetailTicketPromiseCell ()
@property (weak, nonatomic) IBOutlet UILabel *promiseL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation ProductDetailTicketPromiseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.promiseL.attributedText = data.attTicketPromise;
}

@end
