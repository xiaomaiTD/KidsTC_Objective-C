//
//  WolesaleProductDetailV2PlaceCountCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailV2PlaceCountCell.h"

@interface WolesaleProductDetailV2PlaceCountCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation WolesaleProductDetailV2PlaceCountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(WolesaleProductDetailData *)data {
    [super setData:data];
    WholesaleProductDetailBase *base = data.fightGroupBase;
    switch (base.placeType) {
        case PlaceTypeStore:
        {
            self.titleL.text = [NSString stringWithFormat:@"查看全部%zd个活动地点",base.stores.count];
        }
            break;
        case PlaceTypePlace:
        {
            self.titleL.text = [NSString stringWithFormat:@"查看全部%zd个活动地点",base.place.count];
        }
            break;
        default:
            break;
    }
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailBaseCell:actionType:value:)]) {
        [self.delegate wolesaleProductDetailBaseCell:self actionType:WolesaleProductDetailBaseCellActionTypeAddress value:@(YES)];
    }
}
@end
