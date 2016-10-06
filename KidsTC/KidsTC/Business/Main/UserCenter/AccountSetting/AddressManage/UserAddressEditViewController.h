//
//  UserAddressEditViewController.h
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"
#import "UserAddressEditModel.h"
#import "UserAddressManageModel.h"

typedef enum : NSUInteger {
    UserAddressEditTypeAdd=1,//新增
    UserAddressEditTypeModify//修改
} UserAddressEditType;

@interface UserAddressEditViewController : ViewController
@property (nonatomic, assign) UserAddressEditType editType;
@property (nonatomic, strong) UserAddressEditModel *model;
@property (nonatomic, copy) void (^resultBlock)(UserAddressManageDataItem *item);
@end
