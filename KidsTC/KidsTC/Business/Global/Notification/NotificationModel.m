//
//  NotificationModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NotificationModel.h"
#import "NSString+Category.h"

@implementation NotificationAlert

@end

@implementation NotificationAps

@end

@implementation NotificationModel
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"tcMedias" : [NSString class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_content isNotNull]) {
        NSString *snap = @"\n";
        if ([_content containsString:snap]) {
            NSArray<NSString *> *strs = [_content componentsSeparatedByString:snap];
            if (strs.count>1) {
                _title = strs[0];
                _body = strs[1];
            }
        }
    }
    if (![_title isNotNull]) {
        _title = @"消息";
    }
    if (![_body isNotNull]) {
        _body = @"您有新的消息！";
    }
    
    switch (_remindType) {
        case RemindTypeSign:
        case RemindTypeFlashBuy:
        {
            _ID = _remindId;
        }
            break;
        default:
        {
            _ID = _pushId;
        }
            break;
    }
    
    if (![_ID isNotNull]) {
        _ID = @"";
    }
    
    _messageType = MessageTypeRemoteNotification;
    
    if ([_params isNotNull]) {
        NSData *paramData = [_params dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *paramDic = [NSJSONSerialization JSONObjectWithData:paramData options:NSJSONReadingAllowFragments error:nil];
        _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:paramDic];
    }
    return YES;
}
@end
