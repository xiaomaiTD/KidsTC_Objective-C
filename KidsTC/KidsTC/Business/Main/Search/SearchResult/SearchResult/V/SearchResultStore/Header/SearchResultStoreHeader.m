//
//  SearchResultStoreHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultStoreHeader.h"
#import "FiveStarsView.h"
#import "UIImageView+WebCache.h"

@interface SearchResultStoreHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *infoBGView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *areaL;
@property (weak, nonatomic) IBOutlet UIImageView *addressTipImg;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation SearchResultStoreHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.HLineH.constant = LINE_H;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [self addGestureRecognizer:tapGR];
}

- (void)action:(UITapGestureRecognizer *)tapGR {
    if (self.actionBlock) {
        self.actionBlock(_store);
    }
}

- (void)setStore:(SearchResultStore *)store {
    if (![store isKindOfClass:[SearchResultStore class]]) return;
    _store = store;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_store.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = _store.storeName;
    self.starsView.starNumber = _store.level;
    self.areaL.text = [NSString stringWithFormat:@"%@-%@",_store.cityName,_store.districtName];
    self.addressL.text = _store.address;
    self.distanceL.text = _store.distance;
}

@end
