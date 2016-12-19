//
//  ProductDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"
#import "ProductDetailSubViewsProvider.h"

typedef enum : NSUInteger {
    
    //cells
    ProductDetailViewActionTypeSegue = 1,
    ProductDetailViewActionTypeCountDownOver,//倒计时结束
    ProductDetailViewActionTypeShowDate,//显示日期
    ProductDetailViewActionTypeShowAddress,//显示位置
    ProductDetailViewActionTypeOpenWebView,//展开detail
    ProductDetailViewActionTypeAddNewConsult,//新增咨询
    ProductDetailViewActionTypeMoreConsult,//查看更多咨询
    ProductDetailViewActionTypeStandard,//套餐信息
    ProductDetailViewActionTypeBuyStandard,//购买套餐
    ProductDetailViewActionTypeCoupon,//优惠券
    ProductDetailViewActionTypeConsult,//在线咨询
    ProductDetailViewActionTypeContact,//联系商家
    ProductDetailViewActionTypeComment,//查看评论
    ProductDetailViewActionTypeMoreComment,//查看全部评论
    ProductDetailViewActionTypeRecommend,//为您推荐
    ProductDetailViewActionTypeTicketLike,//票务 - 想看
    ProductDetailViewActionTypeTicketStar,//票务 - 评分
    ProductDetailViewActionTypeTicketOpenDes,//票务 - 展开描述
    ProductDetailViewActionTypeFreeStoreDetail,//免费 - 门店详情
    ProductDetailViewActionTypeFreeMoreTricks,//免费 - 更多生活小窍门
    
    //twoColumnToolBar
    ProductDetailViewActionTypeTwoColumnToolBarDetail = 100,//展示商品H5详情
    ProductDetailViewActionTypeTwoColumnToolBarConsult,//展示商品咨询
    
    //countDownView
    ProductDetailViewActionTypeCountDonwFinished = 200,//倒计时结束
    
    //tooBar
    ProductDetailViewActionTypeToolBarConsult = 300,//在线咨询
    ProductDetailViewActionTypeToolBarAttention,//(添加/取消)关注
    ProductDetailViewActionTypeToolBarBuyNow,//立即购买
    ProductDetailViewActionTypeTicketToolBarComment,//票务 - 评价
    ProductDetailViewActionTypeTicketToolBarStar,//票务 - 想看
    ProductDetailViewActionTypeTicketToolBarSelectSeat,//票务 - 选座购票
    ProductDetailViewActionTypeFreeToolBarLike,//免费商详 - 喜欢、收藏
    ProductDetailViewActionTypeFreeToolBarApply,//免费商详 - 我要报名
    ProductDetailViewActionTypeFreeToolBarShare,//免费商详 - 分享
    ProductDetailViewActionTypeFreeToolBarRelateBuy,//免费商详 - 原价购买
    
    //header
    ProductDetailViewActionTypeTicketHeaderLike = 400,//票务 - 想看
    ProductDetailViewActionTypeTicketHeaderStar,//票务 - 评分
    
    //self
    ProductDetailViewDidScroll = 500,//滚动
    
} ProductDetailViewActionType;

@class ProductDetailView;
@protocol ProductDetailViewDelegate <NSObject>
- (void)productDetailView:(ProductDetailView *)view actionType:(ProductDetailViewActionType)type value:(id)value;
@end

@interface ProductDetailView : UIView
@property (nonatomic, strong) ProductDetailSubViewsProvider *subViewProvider;
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<ProductDetailViewDelegate> delegate;
@end
