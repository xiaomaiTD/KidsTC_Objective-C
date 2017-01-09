//
//  RadishOrderDetailStore.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface RadishOrderDetailStore : NSObject
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *hoursDesc;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mapAddress;
//selfDeine
@property (nonatomic, strong) SegueModel *segueModel;
@end
