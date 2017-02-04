//
//  FlashBuyProductDetailStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailStoreCell.h"
#import "FiveStarsView.h"
#import "UIImageView+WebCache.h"

@interface FlashBuyProductDetailStoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation FlashBuyProductDetailStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
}

- (void)setStore:(FlashBuyProductDetailStore *)store {
    _store = store;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:store.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = store.storeName;
    self.distanceL.text = store.distance;
    self.starsView.starNumber = store.level;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailBaseCell:actionType:vlaue:)]) {
        [self.delegate flashBuyProductDetailBaseCell:self actionType:FlashBuyProductDetailBaseCellActionTypeSegue vlaue:self.store.segueModel];
    }
}
@end
