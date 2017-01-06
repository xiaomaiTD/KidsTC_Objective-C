//
//  RadishProductDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishProductDetailData.h"
#import "Colours.h"

typedef enum : NSUInteger {
    
    RadishProductDetailBaseCellActionTypeSegue = 1,
    RadishProductDetailBaseCellActionTypeCountDownOver,//倒计时结束
    RadishProductDetailBaseCellActionTypeShowDate,//显示日期
    RadishProductDetailBaseCellActionTypeShowAddress,//显示位置
    RadishProductDetailBaseCellActionTypeOpenWebView,//展开detail
    RadishProductDetailBaseCellActionTypeWebLoadFinish,//WebView完成加载
    RadishProductDetailBaseCellActionTypeAddNewConsult,//新增咨询
    RadishProductDetailBaseCellActionTypeMoreConsult,//查看更多咨询
    RadishProductDetailBaseCellActionTypeSelectStandard,//选择套餐
    RadishProductDetailBaseCellActionTypeStandard,//套餐信息
    RadishProductDetailBaseCellActionTypeBuyStandard,//购买套餐
    RadishProductDetailBaseCellActionTypeCoupon,//优惠券
    RadishProductDetailBaseCellActionTypeConsult,//在线咨询
    RadishProductDetailBaseCellActionTypeContact,//联系商家
    RadishProductDetailBaseCellActionTypeComment,//查看评论
    RadishProductDetailBaseCellActionTypeMoreComment,//查看全部评论
    RadishProductDetailBaseCellActionTypeTicketLike,//票务 - 想看
    RadishProductDetailBaseCellActionTypeTicketStar,//票务 - 评分
    RadishProductDetailBaseCellActionTypeTicketOpenDes,//票务 - 展开描述
    RadishProductDetailBaseCellActionTypeFreeStoreDetail,//免费 - 门店详情
    RadishProductDetailBaseCellActionTypeFreeMoreTricks,//免费 - 更多生活小窍门
    
} RadishProductDetailBaseCellActionType;

@class RadishProductDetailBaseCell;
@protocol RadishProductDetailBaseCellDelegate <NSObject>
- (void)radishProductDetailBaseCell:(RadishProductDetailBaseCell *)cell actionType:(RadishProductDetailBaseCellActionType)type value:(id)value;
@end

@interface RadishProductDetailBaseCell : UITableViewCell
@property (nonatomic, strong) RadishProductDetailData *data;
@property (nonatomic, weak) id<RadishProductDetailBaseCellDelegate> delegate;
@end
