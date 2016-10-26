//
//  ProductDetailStore.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailStore.h"
#import "NSString+Category.h"

@implementation ProductDetailStore
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _storeName = [_storeName isNotNull]?_storeName:@"";
    _address = [_address isNotNull]?_address:@"";
    _mapAddress = [_mapAddress isNotNull]?_mapAddress:@"";
    return YES;
}
@end
