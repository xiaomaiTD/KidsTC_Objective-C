//
//  WholesaleProductDetailTeamModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleProductDetailTeam.h"
#import "WholesaleProductDetailCount.h"

@interface WholesaleProductDetailTeamModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<WholesaleProductDetailTeam *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
//selfDefine
@property (nonatomic, strong) NSArray<WholesaleProductDetailCount *> *counts;
@end
