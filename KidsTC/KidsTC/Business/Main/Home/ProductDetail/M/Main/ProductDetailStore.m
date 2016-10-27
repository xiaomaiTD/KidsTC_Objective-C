//
//  ProductDetailStore.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailStore.h"
#import "NSString+Category.h"

/*
 string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
 string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
 self.phoneNumbers = [string componentsSeparatedByString:@";"];
 */

@implementation ProductDetailStore
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _storeName = [_storeName isNotNull]?_storeName:@"";
    _address = [_address isNotNull]?_address:@"";
    _mapAddress = [_mapAddress isNotNull]?_mapAddress:@"";
    _phone = [_phone isNotNull]?_phone:@"";
    _phone = [_phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    _phone = [_phone stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.phones = [_phone componentsSeparatedByString:@";"];
    return YES;
}
@end
