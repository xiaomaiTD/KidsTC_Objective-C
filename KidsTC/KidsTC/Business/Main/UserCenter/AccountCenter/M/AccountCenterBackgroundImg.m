//
//  AccountCenterBackgroundImg.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterBackgroundImg.h"

@implementation AccountCenterBackgroundImg
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (_Ratio<=0) {
        _Ratio = 1;
    }
    
    return YES;
}
@end
