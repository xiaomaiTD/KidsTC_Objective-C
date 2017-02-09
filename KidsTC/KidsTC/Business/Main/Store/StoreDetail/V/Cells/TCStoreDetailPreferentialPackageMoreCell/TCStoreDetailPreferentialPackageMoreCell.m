//
//  TCStoreDetailPreferentialPackageMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailPreferentialPackageMoreCell.h"

@interface TCStoreDetailPreferentialPackageMoreCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation TCStoreDetailPreferentialPackageMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    self.titleL.text = [NSString stringWithFormat:@"查看其他%zd个优惠活动",data.productPackage.products.count-3];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypePreferentialPackageMore value:nil];
    }
}
@end
