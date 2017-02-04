//
//  WholesalePickDatePlaceCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesalePickDatePlaceCollectionCell.h"

@interface WholesalePickDatePlaceCollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *tipImg;
@property (weak, nonatomic) IBOutlet UIImageView *storeIcon;
@property (weak, nonatomic) IBOutlet UILabel *storeNameL;
@property (weak, nonatomic) IBOutlet UIImageView *addressIcon;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (nonatomic, assign) BOOL select;
@end

@implementation WholesalePickDatePlaceCollectionCell

- (void)setPlace:(WholesalePickDatePlace *)place {
    _place = place;
    self.storeNameL.text = place.name;
    self.addressL.text = place.address;
    self.select = place.select;
}

- (void)setSelect:(BOOL)select {
    _select = select;
    
    if (self.select) {
        self.bgView.layer.borderColor = [UIColor colorFromHexString:@"ff8888"].CGColor;
        self.bgView.layer.borderWidth = 1;
        self.tipImg.hidden = NO;
        UIColor *textColor = [UIColor colorFromHexString:@"ff8888"];
        self.storeNameL.textColor = textColor;
        self.addressL.textColor = textColor;
        self.storeIcon.image = [UIImage imageNamed:@"wholesalePickDate_Store_Sel"];
        self.addressIcon.image = [UIImage imageNamed:@"wholesalePickDate_Address_Sel"];
    }else{
        self.bgView.layer.borderColor = [UIColor colorFromHexString:@"e5e5e5"].CGColor;
        self.bgView.layer.borderWidth = 1;
        self.tipImg.hidden = YES;
        UIColor *textColor = [UIColor colorFromHexString:@"555555"];
        self.storeNameL.textColor = textColor;
        self.addressL.textColor = textColor;
        self.storeIcon.image = [UIImage imageNamed:@"wholesalePickDate_Store_Nor"];
        self.addressIcon.image = [UIImage imageNamed:@"wholesalePickDate_Address_Nor"];
    }
}

@end
