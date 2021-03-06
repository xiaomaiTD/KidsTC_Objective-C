//
//  ProductDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"
#import "Colours.h"

typedef enum : NSUInteger {
    
    ProductDetailBaseCellActionTypeSegue = 1,
    ProductDetailBaseCellActionTypeCountDownOver,//倒计时结束
    ProductDetailBaseCellActionTypeShowDate,//显示日期
    ProductDetailBaseCellActionTypeShowAddress,//显示位置
    ProductDetailBaseCellActionTypeOpenWebView,//展开detail
    ProductDetailBaseCellActionTypeWebViewFinishLoad,//WebView完成加载
    ProductDetailBaseCellActionTypeAddNewConsult,//新增咨询
    ProductDetailBaseCellActionTypeMoreConsult,//查看更多咨询
    ProductDetailBaseCellActionTypeSelectStandard,//选择套餐
    ProductDetailBaseCellActionTypeStandard,//套餐信息
    ProductDetailBaseCellActionTypeBuyStandard,//购买套餐
    ProductDetailBaseCellActionTypeCoupon,//优惠券
    ProductDetailBaseCellActionTypeConsult,//在线咨询
    ProductDetailBaseCellActionTypeContact,//联系商家
    ProductDetailBaseCellActionTypeComment,//查看评论
    ProductDetailBaseCellActionTypeMoreComment,//查看全部评论
    ProductDetailBaseCellActionTypeTicketLike,//票务 - 想看
    ProductDetailBaseCellActionTypeTicketStar,//票务 - 评分
    ProductDetailBaseCellActionTypeTicketOpenDes,//票务 - 展开描述
    ProductDetailBaseCellActionTypeFreeStoreDetail,//免费 - 门店详情
    ProductDetailBaseCellActionTypeFreeMoreTricks,//免费 - 更多生活小窍门
    
} ProductDetailBaseCellActionType;

@class ProductDetailBaseCell;
@protocol ProductDetailBaseCellDelegate <NSObject>
- (void)productDetailBaseCell:(ProductDetailBaseCell *)cell actionType:(ProductDetailBaseCellActionType)type value:(id)value;
@end

@interface ProductDetailBaseCell : UITableViewCell
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<ProductDetailBaseCellDelegate> delegate;
@end
