//
//  ScoreConsumeTopicModel.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/14.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreConsumeTopicModel.h"

@implementation ScoreConsumeTopicModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[ScoreConsumeTopicItem class]};
}
@end
