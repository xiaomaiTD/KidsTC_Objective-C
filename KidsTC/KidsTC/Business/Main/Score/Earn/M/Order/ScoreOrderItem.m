//
//  ScoreOrderItem.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreOrderItem.h"
#import "NSString+Category.h"

@implementation ScoreOrderItem

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupPhones];
    
    return YES;
}

- (void)setupPhones {
    
    if (![_supplierMobie isNotNull]) {
        return;
    }
    
    if ([_supplierMobie rangeOfString:@";"].length<1) {
        _phones = @[_supplierMobie];
    }else{
        _phones = [_supplierMobie componentsSeparatedByString:@";"];
    }
}
@end
