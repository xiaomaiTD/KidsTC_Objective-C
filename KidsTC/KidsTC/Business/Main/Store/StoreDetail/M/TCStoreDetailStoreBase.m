//
//  TCStoreDetailStoreBase.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailStoreBase.h"
#import "NSString+Category.h"

@implementation TCStoreDetailStoreBase
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"narrowImg":[NSString class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (_picRate<=0) _picRate = 0.3;
    
    [self setupPhones];
    
    return YES;
}

- (void)setupPhones {
    
    if (![_mobile isNotNull]) {
        return;
    }
    
    if ([_mobile rangeOfString:@","].length<1) {
        _phones = @[_mobile];
    }else{
        _phones = [_mobile componentsSeparatedByString:@","];
    }
}

@end
