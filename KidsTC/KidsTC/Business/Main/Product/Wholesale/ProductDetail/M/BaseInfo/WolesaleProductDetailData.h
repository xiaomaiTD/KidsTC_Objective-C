//
//  WolesaleProductDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WholesaleProductDetailBase.h"
#import "WholesalePickDateSKU.h"
@interface WolesaleProductDetailData : NSObject
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, assign) long long openGroupSysNo;
@property (nonatomic, strong) WholesaleProductDetailBase *fightGroupBase;
@property (nonatomic, strong) WholesalePickDateSKU *sku;
@end
