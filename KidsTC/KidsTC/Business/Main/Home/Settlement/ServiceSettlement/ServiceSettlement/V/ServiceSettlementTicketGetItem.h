//
//  ServiceSettlementTicketGetItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceSettlementDataItem.h"
@interface ServiceSettlementTicketGetItem : UIView
@property (nonatomic, assign) ServiceSettlementTakeTicketWay takeTicketWay;
@property (nonatomic, assign) BOOL select;
+ (instancetype)itemWithTitle:(NSString *)title
                     norImage:(NSString *)norImage
                     selImage:(NSString *)selImage
                    norCorlor:(NSString *)norCorlor
                    selCorlor:(NSString *)selCorlor
                takeTicketWay:(ServiceSettlementTakeTicketWay)takeTicketWay
                  actionBlock:(void(^)(ServiceSettlementTicketGetItem *item))actionBlock;
@end
