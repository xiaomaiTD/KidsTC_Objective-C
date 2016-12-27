//
//  WolesaleProductDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WholesaleProductDetailBase.h"

@interface WolesaleProductDetailData : NSObject
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *openGroupSysNo;
@property (nonatomic, strong) WholesaleProductDetailBase *fightGroupBase;
@end
