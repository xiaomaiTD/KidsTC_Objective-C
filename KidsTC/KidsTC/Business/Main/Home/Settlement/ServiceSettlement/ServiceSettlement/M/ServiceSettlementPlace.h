//
//  ServiceSettlementPlace.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceSettlementPlace : NSObject
@property (nonatomic, strong) NSString *sysNo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *distance;
//selfDefine
@property (nonatomic, strong) NSAttributedString *placeDesc;
@end
