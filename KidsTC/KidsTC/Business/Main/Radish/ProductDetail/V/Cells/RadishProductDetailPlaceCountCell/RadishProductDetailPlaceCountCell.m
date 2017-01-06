//
//  RadishProductDetailPlaceCountCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailPlaceCountCell.h"

@interface RadishProductDetailPlaceCountCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation RadishProductDetailPlaceCountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(RadishProductDetailData *)data {
    [super setData:data];
    switch (data.placeType) {
        case PlaceTypeStore:
        {
            self.titleL.text = [NSString stringWithFormat:@"查看全部%zd个活动地点",data.store.count];
        }
            break;
        case PlaceTypePlace:
        {
            self.titleL.text = [NSString stringWithFormat:@"查看全部%zd个活动地点",data.place.count];
        }
            break;
        default:
            break;
    }
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
        [self.delegate radishProductDetailBaseCell:self actionType:RadishProductDetailBaseCellActionTypeShowAddress value:@(YES)];
    }
}
@end
