//
//  SeckillTimeDate.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillTimeDate.h"

@implementation SeckillTimeDate
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"tabs":[SeckillTimeTime class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self setupSelect];
    return YES;
}

- (void)setupSelect {
    __block BOOL hasIsChecked = NO;
    [self.tabs enumerateObjectsUsingBlock:^(SeckillTimeTime * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!hasIsChecked && obj.isChecked) {
            hasIsChecked = YES;
        }else{
            obj.isChecked = NO;
        }
    }];
    if (!hasIsChecked) {
        if (self.tabs.count>0) {
            self.tabs.firstObject.isChecked = YES;
        }
    }
}

@end
