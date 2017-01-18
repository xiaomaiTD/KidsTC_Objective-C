//
//  NearbyTableViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "User.h"
#import "NSString+Category.h"

@interface NearbyTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *categoryL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoryW;
@property (weak, nonatomic) IBOutlet UILabel *areaL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaW;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerIconH;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@end

@implementation NearbyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    self.likeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.categoryL.layer.borderWidth = 1;
    self.categoryL.layer.borderColor = [UIColor colorFromHexString:@"83CEF8"].CGColor;
    self.categoryL.layer.cornerRadius = 2;
    self.categoryL.layer.masksToBounds = YES;
    
    self.areaL.layer.borderWidth = 1;
    self.areaL.layer.borderColor = [UIColor colorFromHexString:@"FE80A5"].CGColor;
    self.areaL.layer.cornerRadius = 2;
    self.areaL.layer.masksToBounds = YES;
}

- (void)setItem:(NearbyItem *)item {
    _item = item;
    [self.bannerIcon sd_setImageWithURL:[NSURL URLWithString:_item.bigImgurl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.bannerIconH.constant = _item.bigImgRatio * (SCREEN_WIDTH - 20);
    self.nameL.text = _item.name;
    self.tipL.text =  [NSString stringWithFormat:@"%@人消费",_item.num];
    self.categoryL.text = _item.categoryName;
    if ([_item.categoryName isNotNull]) {
        self.categoryL.hidden = NO;
        self.categoryW.constant = [_item.categoryName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}].width + 8;
    }else{
        self.categoryL.hidden = YES;
        self.categoryW.constant = 0;
    }
    self.areaL.text = _item.districtName;
    if ([_item.districtName isNotNull]) {
        self.areaL.hidden = NO;
        self.areaW.constant = [_item.districtName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}].width + 8;
    }else{
        self.areaL.hidden = YES;
        self.areaW.constant = 0;
    }
    self.priceL.text = _item.price;
    self.addressL.text = [NSString stringWithFormat:@"%@ %@",_item.storeName,_item.address];
    self.statusL.text = _item.endTimeDesc;
    self.distanceL.text = _item.distance;
    self.likeBtn.selected = _item.isInterest;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (IBAction)action:(UIButton *)sender {
    [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(nearbyTableViewCell:actionType:value:)]) {
            [self.delegate nearbyTableViewCell:self actionType:NearbyTableViewCellActionTypeLike value:_item];
            _item.isInterest = !_item.isInterest;
            self.likeBtn.selected = _item.isInterest;
        }
    }];
}
@end
