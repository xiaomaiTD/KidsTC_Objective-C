//
//  AccountCenterTCECordLink.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterTCECordLink.h"

@implementation AccountCenterTCECordLink
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {

    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    
    return YES;
}
@end
