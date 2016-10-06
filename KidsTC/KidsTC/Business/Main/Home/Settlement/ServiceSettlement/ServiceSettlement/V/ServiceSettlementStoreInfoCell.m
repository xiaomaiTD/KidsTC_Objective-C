//
//  ServiceSettlementStoreInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementStoreInfoCell.h"

@interface ServiceSettlementStoreInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *storeDescLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstranitHeight;

@end

@implementation ServiceSettlementStoreInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstranitHeight.constant = LINE_H;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)action:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
        [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeStore value:nil];
    }
}

- (void)setItem:(ServiceSettlementDataItem *)item{
    [super setItem:item];
    self.storeDescLabel.attributedText = item.store.storeDesc;
}





@end
