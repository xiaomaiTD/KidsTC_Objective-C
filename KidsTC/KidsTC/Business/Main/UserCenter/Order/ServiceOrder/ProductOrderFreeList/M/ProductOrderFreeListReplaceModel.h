//
//  ProductOrderFreeListReplaceModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderFreeListItem.h"

@interface ProductOrderFreeListReplaceModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ProductOrderFreeListItem *data;
@end
