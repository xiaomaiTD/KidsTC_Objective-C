//
//  NearbyTableViewEmptyHeader.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/15.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NearbyTableViewEmptyHeader.h"
#import "KTCMapService.h"
#import "NSString+Category.h"

CGFloat const kNearbyTableViewEmptyHeaderH = 288;

@interface NearbyTableViewEmptyHeader ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation NearbyTableViewEmptyHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self location];
    [NotificationCenter addObserver:self selector:@selector(location) name:kUserLocationHasChangedNotification object:nil];
}

- (void)location {
    NSString *tip = @"您的附近暂时没有服务哦～";
    NSString *locationStr = [[KTCMapService shareKTCMapService] currentLocationString];
    if (![locationStr isNotNull]) {
        tip = @"您的定位没有打开哦～";
    }
    self.tipL.text = tip;
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kUserLocationHasChangedNotification object:nil];
}

@end
