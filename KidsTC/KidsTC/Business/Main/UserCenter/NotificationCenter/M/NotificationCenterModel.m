//
//  NotificationCenterModel.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "NotificationCenterModel.h"
#import "NSString+Category.h"

@implementation NotificationCenterItemDic

@end

@implementation NotificationCenterItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _cellHeight = 42;
    if (_content.length>0) {
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        _cellHeight += [_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-37, 999)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:att context:nil].size.height;
    }
    if (_dic) {
        
        if ([_dic.open isNotNull]) {
            _isCanOpenHome = [@"1" isEqualToString:_dic.open];
        }else if ([_dic.params isNotNull]) {
            NSData *data = [_dic.params dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *param = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            SegueDestination destination = (SegueDestination)[_dic.linkType integerValue];
            _segueModel = [SegueModel modelWithDestination:destination paramRawData:param];
        }
    }
    return YES;
}
@end

@implementation NotificationCenterModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [NotificationCenterItem class]};
}
@end
