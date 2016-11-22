//
//  ServiceSettlementPromotion.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceSettlementPromotion : NSObject
@property (nonatomic, strong) NSString *promotionId;
@property (nonatomic, strong) NSString *fullcutdesc;
@property (nonatomic, assign) CGFloat fiftyamt;
@property (nonatomic, assign) CGFloat promotionamt;
@end
