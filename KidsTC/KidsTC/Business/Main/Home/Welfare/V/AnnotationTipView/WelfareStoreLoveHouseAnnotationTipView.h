//
//  WelfareStoreLoveHouseAnnotationTipView.h
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelfareStoreModel.h"

typedef enum : NSUInteger {
    WelfareStoreLoveHouseAnnotationTipViewActionTypeGoto,
    WelfareStoreLoveHouseAnnotationTipViewActionTypeNearby,
} WelfareStoreLoveHouseAnnotationTipViewActionType;

@class WelfareStoreLoveHouseAnnotationTipView;
@protocol WelfareStoreLoveHouseAnnotationTipViewDelegate <NSObject>
- (void)welfareStoreLoveHouseAnnotationTipView:(WelfareStoreLoveHouseAnnotationTipView *)view actionType:(WelfareStoreLoveHouseAnnotationTipViewActionType)type;
@end
@protocol BMKAnnotation;
@interface WelfareStoreLoveHouseAnnotationTipView : UITableViewCell
@property (nonatomic, strong) WelfareStoreItem *item;
@property (nonatomic, assign) id<BMKAnnotation> annotation;
@property (nonatomic, weak) id<WelfareStoreLoveHouseAnnotationTipViewDelegate> delegate;
@end
