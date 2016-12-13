//
//  ProductOrderTicketDetailModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderTicketDetailData.h"

@interface ProductOrderTicketDetailModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ProductOrderTicketDetailData *data;
@end
