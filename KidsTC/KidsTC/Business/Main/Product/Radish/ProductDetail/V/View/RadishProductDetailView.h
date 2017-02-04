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
    RadishProductDetailViewActionTypeShowDate,//显示日期
    RadishProductDetailViewActionTypeShowAddress,//显示位置
    RadishProductDetailViewActionTypeOpenWebView,//展开detail
    RadishProductDetailViewActionTypeWebLoadFinish,//WebView完成加载
    RadishProductDetailViewActionTypeAddNewConsult,//新增咨询
    RadishProductDetailViewActionTypeMoreConsult,//查看更多咨询
    RadishProductDetailViewActionTypeStandard,//套餐信息
    RadishProductDetailViewActionTypeBuyStandard,//购买套餐
    RadishProductDetailViewActionTypeConsult,//在线咨询
    RadishProductDetailViewActionTypeContact,//联系商家
    RadishProductDetailViewActionTypeComment,//查看评论
    RadishProductDetailViewActionTypeMoreComment,//查看全部评论

    //tooBar
    RadishProductDetailViewActionTypeToolBarCountDonwFinished = 300,//倒计时结束
    RadishProductDetailViewActionTypeToolBarConsult,//在线咨询
    RadishProductDetailViewActionTypeToolBarAttention,//(添加/取消)关注
    RadishProductDetailViewActionTypeToolBarBuyNow,//立即购买
    
} RadishProductDetailViewActionType;

@class RadishProductDetailView;
@protocol RadishProductDetailViewDelegate <NSObject>
- (void)radishProductDetailView:(RadishProductDetailView *)view actionType:(RadishProductDetailViewActionType)type value:(id)value;
@end

@interface RadishProductDetailView : UIView
@property (nonatomic, strong) RadishProductDetailData *data;
@property (nonatomic, weak) id<RadishProductDetailViewDelegate> delegate;
@end
