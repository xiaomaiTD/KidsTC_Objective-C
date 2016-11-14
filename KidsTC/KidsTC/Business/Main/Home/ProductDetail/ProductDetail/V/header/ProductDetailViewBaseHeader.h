//
//  ProductDetailViewBaseHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"

typedef enum : NSUInteger {
    ProductDetailViewBaseHeaderActionTypeTicketLike = 400,//票务 - 想看
    ProductDetailViewBaseHeaderActionTypeTicketStar,//票务 - 评分
} ProductDetailViewBaseHeaderActionType;

@class ProductDetailViewBaseHeader;
@protocol ProductDetailViewBaseHeaderDelegate <NSObject>
- (void)productDetailViewBaseHeader:(ProductDetailViewBaseHeader *)header actionType:(ProductDetailViewBaseHeaderActionType)type value:(id)value;
@end

@interface ProductDetailViewBaseHeader : UIView
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<ProductDetailViewBaseHeaderDelegate> delegate;
@end
