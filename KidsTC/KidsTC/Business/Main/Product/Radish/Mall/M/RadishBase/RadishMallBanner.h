//
//  RadishMallBanner.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface RadishMallBanner : NSObject
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
