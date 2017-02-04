//
//  RadishMallBanner.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallBanner.h"

@implementation RadishMallBanner
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_ratio<=0) {
        _ratio = 0.6;
    }
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    return YES;
}
@end
