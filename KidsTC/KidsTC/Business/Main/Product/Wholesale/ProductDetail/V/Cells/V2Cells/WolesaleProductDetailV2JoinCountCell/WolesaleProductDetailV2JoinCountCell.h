//
//  WolesaleProductDetailV2JoinCountCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailBaseCell.h"

@interface WolesaleProductDetailV2JoinCountCell : WolesaleProductDetailBaseCell
@property (nonatomic, strong) NSArray<WholesaleProductDetailCount *> *counts;
@property (nonatomic, copy) void (^actionBlock)(WholesaleProductDetailCount *item);
@end
