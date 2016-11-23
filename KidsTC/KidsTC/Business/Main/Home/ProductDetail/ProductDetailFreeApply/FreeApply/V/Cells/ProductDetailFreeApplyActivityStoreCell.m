//
//  ProductDetailFreeApplyActivityStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyActivityStoreCell.h"

@interface ProductDetailFreeApplyActivityStoreCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *storeNameL;

@end

@implementation ProductDetailFreeApplyActivityStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
    self.storeNameL.text = showModel.activityStore.storeName;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyBaseCell:actionType:value:)]) {
        [self.delegate productDetailFreeApplyBaseCell:self actionType:ProductDetailFreeApplyBaseCellActionTypeActivityStore value:nil];
    }
}
@end
