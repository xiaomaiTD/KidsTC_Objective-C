//
//  NotificationCenterModel.h
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueMaster.h"

typedef enum : NSUInteger {
    NotificationStatusRead=1,
    NotificationStatusUnread
} NotificationStatus;

@interface NotificationCenterItemDic : NSObject
@property (nonatomic, strong) NSString *linkType;
@property (nonatomic, strong) NSString *params;
@property (nonatomic, strong) NSString *open;
@end

@interface NotificationCenterItem : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NotificationCenterItemDic *dic;
@property (nonatomic, assign) NotificationStatus status;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, assign) NSInteger sysNo;
@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) <#type#> *type;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL isCanOpenHome;
@property (nonatomic, strong) SegueModel *segueModel;
@end

@interface NotificationCenterModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<NotificationCenterItem *> *data;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSString *page;
@end
