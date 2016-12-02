//
//  NearbyTitleView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyTitleView.h"
#import "KTCMapService.h"
#import "NSString+Category.h"

@interface NearbyTitleView ()
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressl;

@property (weak, nonatomic) IBOutlet UIView *searchBarBGView;
@property (weak, nonatomic) IBOutlet UILabel *searchTitleL;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@end

@implementation NearbyTitleView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.searchBarBGView.layer.cornerRadius = 4;
    self.searchBarBGView.layer.masksToBounds = YES;
    self.addressBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.addressBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.addressBtn.tag = NearbyTitleViewActionTypeAddress;
    self.searchBtn.tag = NearbyTitleViewActionTypeSearch;
    
    [self userLocation];
    [NotificationCenter addObserver:self selector:@selector(userLocation) name:kUserLocationHasChangedNotification object:nil];
}


- (void)userLocation {
    NSString *locationString = [KTCMapService shareKTCMapService].currentLocation.locationDescription;
    NSString *address = [locationString isNotNull]?locationString:@"还没有定位哦...";
    self.addressl.text = address;
    //[self.addressBtn setTitle:address forState:UIControlStateNormal];
    
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(nearbyTitleView:actionType:value:)]) {
        [self.delegate nearbyTitleView:self actionType:(NearbyTitleViewActionType)sender.tag value:nil];
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kUserLocationHasChangedNotification object:nil];
}

@end
