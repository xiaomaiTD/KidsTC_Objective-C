//
//  ProductOrderListReplaceModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderListItem.h"

@interface ProductOrderListReplaceModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ProductOrderListItem *data;
@end
