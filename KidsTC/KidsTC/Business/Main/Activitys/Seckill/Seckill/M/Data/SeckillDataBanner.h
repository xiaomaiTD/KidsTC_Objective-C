//
//  SeckillDataBanner.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface SeckillDataBanner : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *sortNo;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *param;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
