//
//  ProductOrderTicketDetailDeliverItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface ProductOrderTicketDetailDeliverItem : NSObject
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, assign) BOOL isCall;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *linkParams;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
