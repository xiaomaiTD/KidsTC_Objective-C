//
//  AccountCenterBanner.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterBanner.h"

@implementation AccountCenterBanner
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _Ratio = _Ratio>0?_Ratio:0.4;
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    return YES;
}
@end
