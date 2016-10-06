//
//  ServiceOrderDetailStoreInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailStoreInfoCell.h"

@interface ServiceOrderDetailStoreInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *storeDescLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstranitHeight;
@end

@implementation ServiceOrderDetailStoreInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstranitHeight.constant = LINE_H;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(ServiceOrderDetailData *)data{
    [super setData:data];
    self.storeDescLabel.attributedText = data.storeInfo.storeDesc;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(serviceOrderDetailBaseCell:actionType:)]) {
        [self.delegate serviceOrderDetailBaseCell:self actionType:ServiceOrderDetailBaseCellActionTypeOrderDetail];
    }
}

@end
