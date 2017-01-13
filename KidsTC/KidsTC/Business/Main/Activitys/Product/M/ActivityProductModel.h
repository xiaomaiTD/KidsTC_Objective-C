//
//  ActivityProductModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityProductData.h"
@interface ActivityProductModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ActivityProductData *data;
@end
