//
//  WolesaleProductDetailModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WolesaleProductDetailData.h"

@interface WolesaleProductDetailModel : NSObject
@property (nonatomic, strong) NSString *errNo;
@property (nonatomic, strong) WolesaleProductDetailData *data;
@end
