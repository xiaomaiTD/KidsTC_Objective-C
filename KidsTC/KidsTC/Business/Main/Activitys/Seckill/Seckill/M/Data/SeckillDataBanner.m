//
//  SeckillDataBanner.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillDataBanner.h"

@implementation SeckillDataBanner
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_ratio<=0) _ratio = 0.6;
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_param];
    return YES;
}
@end
