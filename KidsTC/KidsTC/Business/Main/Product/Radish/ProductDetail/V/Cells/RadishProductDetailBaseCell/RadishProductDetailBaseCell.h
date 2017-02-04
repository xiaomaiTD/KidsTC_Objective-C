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
    RadishProductDetailBaseCellActionTypeShowDate,//显示日期
    RadishProductDetailBaseCellActionTypeShowAddress,//显示位置
    RadishProductDetailBaseCellActionTypeOpenWebView,//展开detail
    RadishProductDetailBaseCellActionTypeWebLoadFinish,//WebView完成加载
    RadishProductDetailBaseCellActionTypeAddNewConsult,//新增咨询
    RadishProductDetailBaseCellActionTypeMoreConsult,//查看更多咨询
    RadishProductDetailBaseCellActionTypeStandard,//套餐信息
    RadishProductDetailBaseCellActionTypeBuyStandard,//购买套餐
    RadishProductDetailBaseCellActionTypeConsult,//在线咨询
    RadishProductDetailBaseCellActionTypeContact,//联系商家
    RadishProductDetailBaseCellActionTypeComment,//查看评论
    RadishProductDetailBaseCellActionTypeMoreComment,//查看全部评论
} RadishProductDetailBaseCellActionType;

@class RadishProductDetailBaseCell;
@protocol RadishProductDetailBaseCellDelegate <NSObject>
- (void)radishProductDetailBaseCell:(RadishProductDetailBaseCell *)cell actionType:(RadishProductDetailBaseCellActionType)type value:(id)value;
@end

@interface RadishProductDetailBaseCell : UITableViewCell
@property (nonatomic, strong) RadishProductDetailData *data;
@property (nonatomic, weak) id<RadishProductDetailBaseCellDelegate> delegate;
@end
