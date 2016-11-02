//
//  NSArray+Category.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)
- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}
@end
