//
//  WholesaleOrderListReplaceModel.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/15.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WholesaleOrderListItem.h"
@interface WholesaleOrderListReplaceModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) WholesaleOrderListItem *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end
