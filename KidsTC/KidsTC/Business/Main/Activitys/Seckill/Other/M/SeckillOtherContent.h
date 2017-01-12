//
//  SeckillOtherContent.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface SeckillOtherContent : NSObject
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, assign) SegueDestination linkType;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
