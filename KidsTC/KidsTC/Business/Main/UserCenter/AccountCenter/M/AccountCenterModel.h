//
//  AccountCenterModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterData.h"

@interface AccountCenterModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) AccountCenterData *data;
@end
