//
//  RadishProductDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RadishProductDetailData.h"

typedef enum : NSUInteger {
    
    //cells
    RadishProductDetailViewActionTypeSegue = 1,
    RadishProductDetailViewActionTypeCountDownOver,//倒计时结束
    RadishProductDetailViewActionTypeShowDate,//显示日期
    RadishProductDetailViewActionTypeShowAddress,//显示位置
    RadishProductDetailViewActionTypeOpenWebView,//展开detail
    RadishProductDetailViewActionTypeWebViewFinishLoad,//WebView完成加载
    RadishProductDetailViewActionTypeAddNewConsult,//新增咨询
    RadishProductDetailViewActionTypeMoreConsult,//查看更多咨询
    RadishProductDetailViewActionTypeSelectStandard,//选择套餐
    RadishProductDetailViewActionTypeStandard,//套餐信息
    RadishProductDetailViewActionTypeBuyStandard,//购买套餐
    RadishProductDetailViewActionTypeCoupon,//优惠券
    RadishProductDetailViewActionTypeConsult,//在线咨询
    RadishProductDetailViewActionTypeContact,//联系商家
    RadishProductDetailViewActionTypeComment,//查看评论
    RadishProductDetailViewActionTypeMoreComment,//查看全部评论
    RadishProductDetailViewActionTypeTicketLike,//票务 - 想看
    RadishProductDetailViewActionTypeTicketStar,//票务 - 评分
    RadishProductDetailViewActionTypeTicketOpenDes,//票务 - 展开描述
    RadishProductDetailViewActionTypeFreeStoreDetail,//免费 - 门店详情
    RadishProductDetailViewActionTypeFreeMoreTricks,//免费 - 更多生活小窍门
    
    //twoColumnToolBar
    RadishProductDetailViewActionTypeTwoColumnToolBarDetail = 100,//展示商品H5详情
    RadishProductDetailViewActionTypeTwoColumnToolBarConsult,//展示商品咨询
    
    //countDownView
    RadishProductDetailViewActionTypeCountDonwFinished = 200,//倒计时结束
    
    //tooBar
    RadishProductDetailViewActionTypeToolBarConsult = 300,//在线咨询
    RadishProductDetailViewActionTypeToolBarAttention,//(添加/取消)关注
    RadishProductDetailViewActionTypeToolBarBuyNow,//立即购买
    RadishProductDetailViewActionTypeTicketToolBarComment,//票务 - 评价
    RadishProductDetailViewActionTypeTicketToolBarStar,//票务 - 想看
    RadishProductDetailViewActionTypeTicketToolBarSelectSeat,//票务 - 选座购票
    RadishProductDetailViewActionTypeFreeToolBarLike,//免费商详 - 喜欢、收藏
    RadishProductDetailViewActionTypeFreeToolBarApply,//免费商详 - 我要报名
    RadishProductDetailViewActionTypeFreeToolBarShare,//免费商详 - 分享
    RadishProductDetailViewActionTypeFreeToolBarRelateBuy,//免费商详 - 原价购买
    
    //header
    RadishProductDetailViewActionTypeTicketHeaderLike = 400,//票务 - 想看
    RadishProductDetailViewActionTypeTicketHeaderStar,//票务 - 评分
    
    //self
    RadishProductDetailViewDidScroll = 500,//滚动
    
} RadishProductDetailViewActionType;

@class RadishProductDetailView;
@protocol RadishProductDetailViewDelegate <NSObject>
- (void)radishProductDetailView:(RadishProductDetailView *)view actionType:(RadishProductDetailViewActionType)type value:(id)value;
@end

@interface RadishProductDetailView : UIView
@property (nonatomic, strong) RadishProductDetailData *data;
@property (nonatomic, weak) id<RadishProductDetailViewDelegate> delegate;
@end
