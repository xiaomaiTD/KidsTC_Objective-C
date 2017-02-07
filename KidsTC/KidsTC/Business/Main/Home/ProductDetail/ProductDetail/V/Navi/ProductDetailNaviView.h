//
//  ProductDetailNaviView.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kProductDetailNaviViewH;

typedef enum : NSUInteger {
    ProductDetailNaviViewActionTypeBack = 600,
    ProductDetailNaviViewActionTypeTime,
    ProductDetailNaviViewActionTypeMore,
} ProductDetailNaviViewActionType;

@class ProductDetailNaviView;
@protocol ProductDetailNaviViewDelegate <NSObject>
- (void)productDetailNaviView:(ProductDetailNaviView *)view actionType:(ProductDetailNaviViewActionType)type value:(id)value;
@end

@interface ProductDetailNaviView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (nonatomic, weak) id<ProductDetailNaviViewDelegate> delegate;
- (void)didScroll:(CGFloat)offsety;
@end
