//
//  WolesaleProductDetailJoinCountCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailBaseCell.h"

@interface WolesaleProductDetailJoinCountCell : WolesaleProductDetailBaseCell
@property (nonatomic, strong) NSArray<WholesaleProductDetailCount *> *counts;
@property (nonatomic, copy) void (^actionBlock)(WholesaleProductDetailCount *item);
@end
