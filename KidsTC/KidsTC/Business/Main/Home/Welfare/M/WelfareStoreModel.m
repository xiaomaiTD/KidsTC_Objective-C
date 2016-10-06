//
//  WelfareStoreModel.m
//  KidsTC
//
//  Created by zhanping on 7/22/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WelfareStoreModel.h"
#import "ToolBox.h"

@implementation WelfareStoreItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _cellHeight = 136;
    if (_desc.length>0) {
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        _cellHeight += [_desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-16, 999)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:att context:nil].size.height;
    }
    
    if (_coordinate.length>0) {
        _coordinate2D = [ToolBox coordinateFromString:_coordinate];
    }
    
    return YES;
}

@end

@implementation WelfareStoreModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [WelfareStoreItem class]};
}
@end
