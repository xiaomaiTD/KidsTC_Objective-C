//
//  ProductDetailStore.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailStore.h"
#import "NSString+Category.h"

#import "ToolBox.h"


@implementation ProductDetailStore
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _storeName = [_storeName isNotNull]?_storeName:@"";
    _address = [_address isNotNull]?_address:@"";
    _mapAddress = [_mapAddress isNotNull]?_mapAddress:@"";
    _phone = [_phone isNotNull]?_phone:@"";
    _phone = [_phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    _phone = [_phone stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.phones = [_phone componentsSeparatedByString:@";"];
    
    //location
    CLLocationCoordinate2D coord = [ToolBox coordinateFromString:[dic objectForKey:@"mapAddress"]];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    self.location = [[KTCLocation alloc] initWithLocation:loc locationDescription:self.storeName];
    NSString *storeAddress = [dic objectForKey:@"address"];
    if ([storeAddress isKindOfClass:[NSString class]]) {
        [self.location setMoreDescription:storeAddress];
    }
    
    return YES;
}


@end
