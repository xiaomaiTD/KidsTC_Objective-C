
//
//  CollectionTarentoItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionTarentoItem.h"

@implementation CollectionTarentoItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"articleLst":[ArticleHomeItem class]};
}
@end
