//
//  ProductOrderFreeDetailLotteryItemCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailLotteryItemCell.h"
#import "Colours.h"

@interface ProductOrderFreeDetailLotteryItemCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@end

@implementation ProductOrderFreeDetailLotteryItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItem:(ProductOrderFreeDetailLotteryItem *)item {
    _item = item;
    self.nameL.text = _item.userName;
    self.phoneL.text = _item.userPhone;
    self.timeL.text = _item.rowCreateTimeStr;
    
    UIColor *textColor = [UIColor colorFromHexString:@"444444"];
    if ((_item.index == 0) && (self.infoData.isLottery)) {
        textColor = COLOR_PINK;
    }
    self.nameL.textColor = textColor;
    self.phoneL.textColor = textColor;
    self.timeL.textColor = textColor;
    
    UIColor *bgColor = (_item.index%2 == 1)?[UIColor whiteColor]:[UIColor colorFromHexString:@"f9f9f9"];
    self.contentView.backgroundColor = bgColor;
}

@end
