//
//  StoreDetailAnnotationTipView.h
//  KidsTC
//
//  Created by zhanping on 8/2/16.
//  Copyright © 2016 詹平. All rights reserved.
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
@interface StoreDetailAnnotationTipView : UITableViewCell
@property (nonatomic, weak) id<StoreDetailAnnotationTipViewDelegate> delegate;
@property (nonatomic, strong) StoreListItemModel *model;
@property (nonatomic, assign) id<BMKAnnotation> annotation;
@end
