//
//  WholesaleProductDetailBase.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleProductDetailBase.h"

@implementation WholesaleProductDetailBase
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"buyNotice" : [WholesaleProductDetailBuyNotice class]};
}
@end
