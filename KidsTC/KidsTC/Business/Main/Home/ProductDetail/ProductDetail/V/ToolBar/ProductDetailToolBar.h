//
//  ProductDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"

extern CGFloat const kProductDetailToolBarHeight;

typedef enum : NSUInteger {
    ProductDetailToolBarBtnTypeContact=1,
    ProductDetailToolBarBtnTypeAttention,
    ProductDetailToolBarBtnTypeBuy,
} ProductDetailToolBarBtnType;

@class ProductDetailToolBar;
@protocol ProductDetailToolBarDelegate <NSObject>

- (void)productDetailToolBar:(ProductDetailToolBar *)toolBar btnType:(ProductDetailToolBarBtnType)type value:(id)value;

@end

@interface ProductDetailToolBar : UIView
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<ProductDetailToolBarDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@end
