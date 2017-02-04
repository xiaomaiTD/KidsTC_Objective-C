//
//  RadishProductOrderListDeliverItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SegueModel.h"
@interface RadishProductOrderListDeliverItem : NSObject
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, assign) BOOL isCall;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *linkParams;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
