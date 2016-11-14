//
//  ProductDetailBaseToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"

extern CGFloat const kProductDetailBaseToolBarHeight;

typedef enum : NSUInteger {
    
    ProductDetailBaseToolBarActionTypeConsult = 300,//在线咨询
    ProductDetailBaseToolBarActionTypeAttention,//(添加/取消)关注
    ProductDetailBaseToolBarActionTypeBuyNow,//立即购买
    
    ProductDetailBaseToolBarActionTypeTicketToolBarComment,//票务 - 评价
    ProductDetailBaseToolBarActionTypeTicketToolBarStar,//票务 - 想看
    ProductDetailBaseToolBarActionTypeTicketToolBarSelectSeat,//票务 - 选座购票
    
    
} ProductDetailBaseToolBarActionType;

@class ProductDetailBaseToolBar;
@protocol ProductDetailBaseToolBarDelegate <NSObject>
- (void)productDetailBaseToolBar:(ProductDetailBaseToolBar *)toolBar actionType:(ProductDetailBaseToolBarActionType)type value:(id)value;
@end

@interface ProductDetailBaseToolBar : UIView
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<ProductDetailBaseToolBarDelegate> delegate;
@end
