//
//  ProductDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"

typedef enum : NSUInteger {
    ProductDetailViewActionTypeSegue = 1,
    ProductDetailViewActionTypeLoadData,//加载商品详情数据
    ProductDetailViewActionTypeDate,//显示日期
    ProductDetailViewActionTypeAddress,//显示位置
    ProductDetailViewActionTypeLoadConsult,//当没有咨询的时候加载更多的咨询
    ProductDetailViewActionTypeAddNewConsult,//新增咨询
    ProductDetailViewActionTypeMoreConsult,//更多咨询
    ProductDetailViewActionTypeStandard,//套餐信息
    ProductDetailViewActionTypeBuyStandard,//购买套餐
    ProductDetailViewActionTypeCoupon,//优惠券
    ProductDetailViewActionTypeConsult,//在线咨询
    ProductDetailViewActionTypeContact,//联系商家
    ProductDetailViewActionTypeComment,//查看评论
    ProductDetailViewActionTypeMoreComment,//查看全部评论
    ProductDetailViewActionTypeRecommend,//为您推荐
    ProductDetailViewActionTypeAttention,//关注
    ProductDetailViewActionTypeBuyNow,//立即购买
} ProductDetailViewActionType;

@class ProductDetailView;
@protocol ProductDetailViewDelegate <NSObject>
- (void)productDetailView:(ProductDetailView *)view actionType:(ProductDetailViewActionType)type value:(id)value;
@end

@interface ProductDetailView : UIView
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<ProductDetailViewDelegate> delegate;
@end
