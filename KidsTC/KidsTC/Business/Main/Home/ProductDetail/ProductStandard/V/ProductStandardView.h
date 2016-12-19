//
//  ProductStandardView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailStandard.h"
#import "ProductStandardDetailData.h"

typedef enum : NSUInteger {
    ProductStandardViewActionTypeDidSelectStandard = 1,//选好套餐
    ProductStandardViewActionTypeClose,//关闭页面
    ProductStandardViewActionTypeBuy,//立即购买
} ProductStandardViewActionType;
@class ProductStandardView;
@protocol ProductStandardViewDelegate <NSObject>
- (void)productStandardView:(ProductStandardView *)view actionType:(ProductStandardViewActionType)type value:(id)value;
@end

@interface ProductStandardView : UIView
@property (nonatomic, strong) NSArray<ProductDetailStandard *> *product_standards;
@property (nonatomic, strong) ProductStandardDetailData *standardDetailData;
@property (nonatomic, weak) id<ProductStandardViewDelegate> delegate;
- (void)show;
- (void)hide:(void(^)())completionBlock;
@end
