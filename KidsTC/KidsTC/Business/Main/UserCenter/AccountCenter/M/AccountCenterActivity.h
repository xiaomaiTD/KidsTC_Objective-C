//
//  AccountCenterActivity.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface AccountCenterActivity : NSObject
@property (nonatomic, assign) CGFloat Ratio;
@property (nonatomic, strong) NSString *ImageUrl;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *name;

//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
