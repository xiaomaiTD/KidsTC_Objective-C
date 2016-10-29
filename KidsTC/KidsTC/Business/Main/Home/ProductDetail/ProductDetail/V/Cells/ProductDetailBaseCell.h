//
//  ProductDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"

typedef enum : NSUInteger {
    ProductDetailBaseCellActionTypeSegue = 1,
    ProductDetailBaseCellActionTypeShowDate,//显示日期
    ProductDetailBaseCellActionTypeShowAddress,//显示位置
    ProductDetailBaseCellActionTypeAddNewConsult,//新增咨询
    ProductDetailBaseCellActionTypeMoreConsult,//查看更多咨询
    ProductDetailBaseCellActionTypeStandard,//套餐信息
    ProductDetailBaseCellActionTypeBuyStandard,//购买套餐
    ProductDetailBaseCellActionTypeCoupon,//优惠券
    ProductDetailBaseCellActionTypeConsult,//在线咨询
    ProductDetailBaseCellActionTypeContact,//联系商家
    ProductDetailBaseCellActionTypeComment,//查看评论
    ProductDetailBaseCellActionTypeMoreComment,//查看全部评论
    ProductDetailBaseCellActionTypeRecommend,//为您推荐
    
    ProductDetailBaseCellActionTypeOpenWebView,//展开detail
    ProductDetailBaseCellActionTypeReloadConsult,//刷新咨询
} ProductDetailBaseCellActionType;

@class ProductDetailBaseCell;
@protocol ProductDetailBaseCellDelegate <NSObject>
- (void)productDetailBaseCell:(ProductDetailBaseCell *)cell actionType:(ProductDetailBaseCellActionType)type value:(id)value;
@end

@interface ProductDetailBaseCell : UITableViewCell
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<ProductDetailBaseCellDelegate> delegate;
@end
