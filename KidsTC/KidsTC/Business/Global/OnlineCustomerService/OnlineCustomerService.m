//
//  OnlineCustomerService.m
//  KidsTC
//
//  Created by Altair on 12/10/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "OnlineCustomerService.h"
#import "InterfaceManager.h"
#import "iToast.h"

@implementation OnlineCustomerService

+ (BOOL)serviceIsOnline {
    NSString *link = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    if (![link isKindOfClass:[NSString class]] || [link length] == 0) {
        return NO;
    }
    return YES;
}

+ (NSString *)onlineCustomerServiceLinkUrlString {
    
    InterfaceItem *item = [[InterfaceManager shareInterfaceManager] interfaceItemWithName:@"KEFU_URL"];
    if (item.url.length>0) {
        return item.url;
    }else{
        [[iToast makeText:@"暂无在线服务"] show];
        return nil;
    }
}

@end
