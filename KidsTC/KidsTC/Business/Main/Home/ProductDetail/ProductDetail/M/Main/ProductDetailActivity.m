//
//  ProductDetailActivity.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ProductDetailActivity.h"

@implementation ProductDetailActivity
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    return YES;
}
@end
