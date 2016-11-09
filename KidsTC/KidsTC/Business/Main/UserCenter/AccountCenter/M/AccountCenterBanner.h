//
//  AccountCenterBanner.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface AccountCenterBanner : NSObject
@property (nonatomic, assign) CGFloat Ratio;
@property (nonatomic, strong) NSString *ImageUrl;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
