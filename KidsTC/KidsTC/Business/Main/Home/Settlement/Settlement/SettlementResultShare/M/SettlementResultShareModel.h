//
//  SettlementResultShareModel.h
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonShareObject.h"
#import "KTCShareService.h"
@interface SettlementResultShareData : NSObject
@property (nonatomic, strong) NSString *tit;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *pageUrl;
@property (nonatomic, strong) NSString *shareTips;
@property (nonatomic, assign) KTCShareServiceType userShareType;
@property (nonatomic, assign) long shareSysNo;
@property (nonatomic, strong) NSString *shareName;

@property (nonatomic, strong) CommonShareObject *shareObj;
@end

@interface SettlementResultShareModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) SettlementResultShareData *data;
@end
