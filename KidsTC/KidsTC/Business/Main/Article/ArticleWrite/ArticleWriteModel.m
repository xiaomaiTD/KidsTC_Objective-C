//
//  ArticleWriteModel.m
//  KidsTC
//
//  Created by zhanping on 9/8/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleWriteModel.h"

@implementation ArticleWriteModel

+(instancetype)modelWith:(ArticleWriteModelType)type{
    ArticleWriteModel *model = [[self alloc] init];
    model.type = type;
    model.canEdit = YES;
    return model;
}
@end
