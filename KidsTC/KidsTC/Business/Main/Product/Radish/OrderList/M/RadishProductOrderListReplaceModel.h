//
//  RadishProductOrderListReplaceModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadishProductOrderListItem.h"

@interface RadishProductOrderListReplaceModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) RadishProductOrderListItem *data;
@end
