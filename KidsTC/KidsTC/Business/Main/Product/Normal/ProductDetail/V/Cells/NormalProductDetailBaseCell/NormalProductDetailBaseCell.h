//
//  NormalProductDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormalProductDetailData.h"

typedef enum : NSUInteger {
    NormalProductDetailBaseCellActionTypeShowAddress = 1,
    NormalProductDetailBaseCellActionTypeAddNewConsult,
    NormalProductDetailBaseCellActionTypeMoreConsult,
    NormalProductDetailBaseCellActionTypeOpenWebView,
    NormalProductDetailBaseCellActionTypeWebViewFinishLoad,
    NormalProductDetailBaseCellActionTypeComment,
    NormalProductDetailBaseCellActionTypeMoreComment,
    NormalProductDetailBaseCellActionTypeCoupon,
    NormalProductDetailBaseCellActionTypeShowDate,
    NormalProductDetailBaseCellActionTypeSegue,
    NormalProductDetailBaseCellActionTypeCountDownOver,
    NormalProductDetailBaseCellActionTypeSelectStandard,
    NormalProductDetailBaseCellActionTypeStandard,
    NormalProductDetailBaseCellActionTypeBuyStandard,
    NormalProductDetailBaseCellActionTypeConsult,
    NormalProductDetailBaseCellActionTypeContact,
} NormalProductDetailBaseCellActionType;
@class NormalProductDetailBaseCell;
@protocol NormalProductDetailBaseCellDelegate <NSObject>
- (void)normalProductDetailBaseCell:(NormalProductDetailBaseCell *)cell actionType:(NormalProductDetailBaseCellActionType)type value:(id)value;
@end

@interface NormalProductDetailBaseCell : UITableViewCell
@property (nonatomic, strong) NormalProductDetailData *data;
@property (nonatomic, weak) id<NormalProductDetailBaseCellDelegate> delegate;
@end
