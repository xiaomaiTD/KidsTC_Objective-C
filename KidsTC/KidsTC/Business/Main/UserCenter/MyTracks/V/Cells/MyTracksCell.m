//
//  MyTracksCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksCell.h"

#import "Colours.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"

@interface MyTracksCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *banner;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UIImageView *reduceImg;
@property (weak, nonatomic) IBOutlet UILabel *reduceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerH;


@end

@implementation MyTracksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setItem:(MyTracksItem *)item {
    _item = item;
    
    [self.banner sd_setImageWithURL:[NSURL URLWithString:_item.picUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.nameL.text = _item.productName;
    self.addressL.text = [NSString stringWithFormat:@"%@ %@",_item.storeName,_item.distanceDesc];
    self.statusL.text = _item.validTimeDesc;
    self.priceL.text = [NSString stringWithFormat:@"%@",_item.nowPrice];
    self.bannerH.constant = CGRectGetWidth(self.banner.frame) * _item.picRatio;
    
    switch (_item.priceStatus) {
        case MyTracksPriceStatusDown:
        {
            self.reduceImg.hidden = NO;
            self.reduceL.hidden = NO;
            self.reduceL.text = [NSString stringWithFormat:@"比看过时下降了¥%@",_item.gapPrice];
        }
            break;
            
        default:
        {
            self.reduceImg.hidden = YES;
            self.reduceL.hidden = YES;
        }
            break;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (IBAction)action:(UIButton *)sender {
    if (self.deleteAction) {
        self.deleteAction();
    }
}


@end
