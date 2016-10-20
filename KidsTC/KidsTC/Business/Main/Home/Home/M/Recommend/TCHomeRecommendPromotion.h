//
//  TCHomeRecommendPromotion.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    TCHomeRecommendPromotionIconTypeNone,
    TCHomeRecommendPromotionIconTypeLocal,
    TCHomeRecommendPromotionIconTypeUrl,
} TCHomeRecommendPromotionIconType;

@interface TCHomeRecommendPromotion : NSObject
@property (nonatomic, assign) TCHomeRecommendPromotionIconType iconType;
@property (nonatomic, strong) NSString *iconUrl;
@end
