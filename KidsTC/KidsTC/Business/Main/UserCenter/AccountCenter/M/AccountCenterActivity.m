//
//  AccountCenterActivity.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterActivity.h"

@implementation AccountCenterActivity
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (_Ratio<=0) {
        _Ratio = 0.6;
    }
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    
    return YES;
}
@end
