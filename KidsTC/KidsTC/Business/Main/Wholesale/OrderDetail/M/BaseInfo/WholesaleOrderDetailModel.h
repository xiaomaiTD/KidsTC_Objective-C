//
//  WholesaleOrderDetailModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailData.h"

@interface WholesaleOrderDetailModel : NSObject
@property (nonatomic, strong) NSString *errNo;
@property (nonatomic, strong) WholesaleOrderDetailData *data;
@end
