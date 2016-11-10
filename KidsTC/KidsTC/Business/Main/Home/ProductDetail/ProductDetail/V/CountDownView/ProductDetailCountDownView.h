//
//  ProductDetailCountDownView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"

extern CGFloat const kProductDetailCountDownViewHeight;

typedef enum : NSUInteger {
    ProductDetailCountDownViewActionTypeCountDonwFinished = 200,//倒计时结束
} ProductDetailCountDownViewActionType;

@class ProductDetailCountDownView;
@protocol ProductDetailCountDownViewDelegte <NSObject>
- (void)productDetailCountDownView:(ProductDetailCountDownView *)view actionType:(ProductDetailCountDownViewActionType)type value:(id)value;
@end

@interface ProductDetailCountDownView : UIView
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<ProductDetailCountDownViewDelegte> delegate;
@end
