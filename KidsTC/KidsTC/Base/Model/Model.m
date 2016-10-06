//
//  Model.m
//  KidsTC
//
//  Created by zhanping on 7/21/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "Model.h"
#import "YYKit.h"
@implementation Model
- (void)encodeWithCoder:(NSCoder *)aCoder { [self modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self modelCopy]; }
- (NSUInteger)hash { return [self modelHash]; }
- (BOOL)isEqual:(id)object { return [self modelIsEqual:object]; }
@end
