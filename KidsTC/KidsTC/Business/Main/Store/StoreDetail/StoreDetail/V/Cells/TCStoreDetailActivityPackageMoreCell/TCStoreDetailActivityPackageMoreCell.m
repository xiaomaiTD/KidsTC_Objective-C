//
//  TCStoreDetailActivityPackageMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailActivityPackageMoreCell.h"

@interface TCStoreDetailActivityPackageMoreCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation TCStoreDetailActivityPackageMoreCell

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    self.titleL.text = [NSString stringWithFormat:@"全部%zd个活动",data.moreProductPackage.products.count];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypePackageMore value:nil];
    }
}
@end
