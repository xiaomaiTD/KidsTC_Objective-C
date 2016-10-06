//
//  PushNotificationModel.m
//  KidsTC
//
//  Created by Altair on 11/30/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "PushNotificationModel.h"
#import "ToolBox.h"
@implementation PushNotificationModel

- (instancetype)initWithRawData:(NSDictionary *)data {
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        
        self.identifier = [NSString stringWithFormat:@"%@", [data objectForKey:@"sysNo"]];
        self.remindType = (RemindType)[[data objectForKey:@"remindType"] integerValue];
        self.messageType = MessageTypeUserCenter;
        self.title = [data objectForKey:@"title"];
        self.content = [data objectForKey:@"content"];
        self.createTimeDescription = [data objectForKey:@"createTime"];
        self.updateTimeDescription = [data objectForKey:@"updateTime"];
        self.status = (PushNotificationStatus)[[data objectForKey:@"status"] integerValue];
        NSDictionary *dic = [data objectForKey:@"dic"];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            SegueDestination dest = (SegueDestination)[[dic objectForKey:@"linkType"] integerValue];
            if (dest != SegueDestinationNone) {
                NSString *paramString = [dic objectForKey:@"params"];
                NSData *paramData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *paramDic = [NSJSONSerialization JSONObjectWithData:paramData options:NSJSONReadingAllowFragments error:nil];
                self.segueModel = [SegueModel modelWithDestination:dest paramRawData:paramDic];
            }
        }
    }
    return self;
}

- (instancetype)initWithRemoteNotificationData:(NSDictionary *)data {
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.remindType = (RemindType)[[data objectForKey:@"remindType"] integerValue];
        self.messageType = MessageTypeRemoteNotification;
        
        if (self.remindType == RemindTypeSign || self.remindType == RemindTypeFlashBuy) {
            self.identifier = data[@"remindId"];
        }else if (self.remindType == RemindTypeNormol){
            self.identifier = data[@"pushId"];
        }else{
            self.remindType = RemindTypeNormol;
            self.identifier = data[@"pushId"];
        }
        
        self.createTimeDescription = [data objectForKey:@"pushtime"];
        SegueDestination dest = (SegueDestination)[[data objectForKey:@"linkType"] integerValue];
        if (dest != SegueDestinationNone) {
            NSString *paramString = [data objectForKey:@"params"];
            NSData *paramData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *paramDic = [NSJSONSerialization JSONObjectWithData:paramData options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"paramDic:%@",paramDic);
            
            self.segueModel = [SegueModel modelWithDestination:dest paramRawData:paramDic];
        }
    }
    return self;
}

- (CGFloat)cellHeight {
    CGFloat height = 27;
    
    height += [ToolBox heightForLabelWithWidth:SCREEN_WIDTH - 45 LineBreakMode:NSLineBreakByCharWrapping Font:[UIFont systemFontOfSize:12] topGap:10 bottomGap:10 andText:self.content];
    
    return height;
}

@end
