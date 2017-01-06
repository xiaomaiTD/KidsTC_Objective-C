//
//  RadishProductDetailPlaceCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailPlaceCell.h"
#import "NSString+Category.h"

@interface RadishProductDetailPlaceCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation RadishProductDetailPlaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(RadishProductDetailData *)data {
    [super setData:data];
    switch (data.placeType) {
        case PlaceTypeStore:
        {
            if (data.store.count>0) {
                RadishProductDetailStore *store = data.store.firstObject;
                self.nameL.text = store.storeName;
                self.distanceL.text = [store.distance isNotNull]?[NSString stringWithFormat:@"距离：%@",store.distance]:nil;
                self.addressL.text = store.address;
            }
        }
            break;
        case PlaceTypePlace:
        {
            if (data.place.count>0) {
                RadishProductDetailPlace *place = data.place.firstObject;
                self.nameL.text = place.name;
                self.distanceL.text = [place.distance isNotNull]?[NSString stringWithFormat:@"距离：%@",place.distance]:nil;
                self.addressL.text = place.address;
            }
        }
            break;
        default:
            break;
    }
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
        [self.delegate radishProductDetailBaseCell:self actionType:RadishProductDetailBaseCellActionTypeShowAddress value:@(NO)];
    }
}

@end
