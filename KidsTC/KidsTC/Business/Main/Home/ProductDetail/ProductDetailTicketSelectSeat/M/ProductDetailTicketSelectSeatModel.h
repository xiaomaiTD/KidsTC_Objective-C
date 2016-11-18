//
//  ProductDetailTicketSelectSeatModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetailTicketSelectSeatData.h"

@interface ProductDetailTicketSelectSeatModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ProductDetailTicketSelectSeatData *data;
@end
