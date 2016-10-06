//
//  StrategyTagColumnModel.m
//  KidsTC
//
//  Created by zhanping on 6/12/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyTagColumnModel.h"

@implementation StrategyTagColumnShare

@end


@implementation StrategyTagColumnData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"list" : [StrategyListItem class]};
}
@end

@implementation StrategyTagColumnModel

@end
