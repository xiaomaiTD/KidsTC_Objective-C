//
//  ProductOrderFreeDetailStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailStoreCell.h"

@interface ProductOrderFreeDetailStoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation ProductOrderFreeDetailStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setInfoData:(ProductOrderFreeDetailData *)infoData {
    [super setInfoData:infoData];
    ProductOrderFreeDetailStore *storeInfo = infoData.storeInfo;
    self.titleL.text = storeInfo.storeName;
}

- (void)setLotteryData:(ProductOrderFreeDetailLotteryData *)lotteryData {
    [super setLotteryData:lotteryData];
}

@end
