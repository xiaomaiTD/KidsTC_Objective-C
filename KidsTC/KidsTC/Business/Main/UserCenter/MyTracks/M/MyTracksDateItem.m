//
//  MyTracksDateItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/30.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksDateItem.h"

@implementation MyTracksDateItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"BrowseHistoryLst":[MyTracksItem class]};
}
@end
