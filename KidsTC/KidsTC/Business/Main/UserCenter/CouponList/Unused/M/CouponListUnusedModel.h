//
//  CouponListUnusedModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListItem.h"

@interface CouponListUnusedModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<CouponListItem *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end
