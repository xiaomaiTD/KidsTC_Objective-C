//
//  RecommendTarento.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendTarento.h"

@implementation RecommendTarento
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"articleLst":[ArticleHomeItem class]};
}
@end
