//
//  FlashBuyProductDetailBuyNoticeElementCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailBuyNoticeElementCell.h"

@interface FlashBuyProductDetailBuyNoticeElementCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;

@end

@implementation FlashBuyProductDetailBuyNoticeElementCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setBuyNotice:(FlashBuyProductDetailBuyNotice *)buyNotice {
    _buyNotice = buyNotice;
    self.titleL.text = [NSString stringWithFormat:@"%@：",buyNotice.clause];
    self.contentL.text = buyNotice.notice;
}

@end
