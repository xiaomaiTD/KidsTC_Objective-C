//
//  WholesaleSettlementStoreInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementStoreInfoCell.h"

@interface WholesaleSettlementStoreInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@end

@implementation WholesaleSettlementStoreInfoCell

- (void)setData:(WholesaleSettlementData *)data {
    [super setData:data];
    
    WholesalePickDateSKU *sku = self.data.sku;
    [sku.places enumerateObjectsUsingBlock:^(WholesalePickDatePlace *obj, NSUInteger idx, BOOL *stop) {
        if (obj.select) {
            self.nameL.text = obj.name;
            self.addressL.text = obj.address;
            *stop = YES;
        }
    }];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wholesaleSettlementBaseCell:actionType:value:)]) {
        [self.delegate wholesaleSettlementBaseCell:self actionType:WholesaleSettlementBaseCellActionTypeSelectPlace value:nil];
    }
}

@end
