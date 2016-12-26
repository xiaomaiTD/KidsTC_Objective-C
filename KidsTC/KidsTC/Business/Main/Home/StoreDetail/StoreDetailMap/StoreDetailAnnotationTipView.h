//
//  StoreDetailAnnotationTipView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreListItemModel.h"

typedef enum : NSUInteger {
    StoreDetailAnnotationTipViewActionTypeGoto,
    StoreDetailAnnotationTipViewActionTypeShow
} StoreDetailAnnotationTipViewActionType;

@class StoreDetailAnnotationTipView;
@protocol StoreDetailAnnotationTipViewDelegate <NSObject>
- (void)storeDetailAnnotationTipView:(StoreDetailAnnotationTipView *)view actionType:(StoreDetailAnnotationTipViewActionType)type;
@end
@protocol BMKAnnotation;
@interface StoreDetailAnnotationTipView : UIView
@property (nonatomic, weak) id<StoreDetailAnnotationTipViewDelegate> delegate;
@property (nonatomic, strong) StoreListItemModel *model;
@property (nonatomic, assign) id<BMKAnnotation> annotation;
@end
