//
//  ProductOrderNormalDetailHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProductOrderNormalDetailHeaderActionTypeClose = 1,
    ProductOrderNormalDetailHeaderActionTypeShowRule,
} ProductOrderNormalDetailHeaderActionType;

@class ProductOrderNormalDetailHeader;
@protocol ProductOrderNormalDetailHeaderDelegate <NSObject>
- (void)productOrderNormalDetailHeader:(ProductOrderNormalDetailHeader *)header actionType:(ProductOrderNormalDetailHeaderActionType)type;
@end

@interface ProductOrderNormalDetailHeader : UIView
@property (nonatomic, assign) id<ProductOrderNormalDetailHeaderDelegate> delegate;
@end
