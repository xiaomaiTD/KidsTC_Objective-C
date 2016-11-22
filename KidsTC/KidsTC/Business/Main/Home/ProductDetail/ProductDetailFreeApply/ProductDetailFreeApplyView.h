//
//  ProductDetailFreeApplyView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"
#import "ProductDetailFreeApplyShowModel.h"

typedef enum : NSUInteger {
    ProductDetailFreeApplyViewActionTypeUserAddressTip = 1,
    ProductDetailFreeApplyViewActionTypeUserAddress,
    ProductDetailFreeApplyViewActionTypeActivityDate,
    ProductDetailFreeApplyViewActionTypeActivityStore,
    ProductDetailFreeApplyViewActionTypeSelectBirth,
    ProductDetailFreeApplyViewActionTypeSelectAge,
    ProductDetailFreeApplyViewActionTypeSelectSex,
    
    ProductDetailFreeApplyViewActionTypeSure = 100,
} ProductDetailFreeApplyViewActionType;

@class ProductDetailFreeApplyView;
@protocol ProductDetailFreeApplyViewDelegate <NSObject>
- (void)productDetailFreeApplyView:(ProductDetailFreeApplyView *)view actionType:(ProductDetailFreeApplyViewActionType)type value:(id)value;
@end

@interface ProductDetailFreeApplyView : UIView
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, strong) ProductDetailFreeApplyShowModel *showModel;
@property (nonatomic, weak) id<ProductDetailFreeApplyViewDelegate> delegate;
- (void)reloadData;
- (void)reloadSections;
@end
