//
//  ProductDetailTwoColumnToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"

extern CGFloat const kTwoColumnToolBarH;

typedef enum : NSUInteger {
    ProductDetailTwoColumnToolBarActionTypeDetail = 100,//商品H5详情
    ProductDetailTwoColumnToolBarActionTypeConsult//商品咨询
} ProductDetailTwoColumnToolBarActionType;

@class ProductDetailTwoColumnToolBar;

@protocol ProductDetailTwoColumnToolBarDelegate <NSObject>
- (void)productDetailTwoColumnToolBar:(ProductDetailTwoColumnToolBar *)toolBar ationType:(ProductDetailTwoColumnToolBarActionType)type value:(id)value;
@end

@interface ProductDetailTwoColumnToolBar : UIView
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<ProductDetailTwoColumnToolBarDelegate> delegate;

@end
