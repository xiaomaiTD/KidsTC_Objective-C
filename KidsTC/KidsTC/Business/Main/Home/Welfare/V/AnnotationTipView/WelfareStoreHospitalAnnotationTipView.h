//
//  WelfareStoreHospitalAnnotationTipView.h
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelfareStoreModel.h"

typedef enum : NSUInteger {
    WelfareStoreHospitalAnnotationTipViewActionTypePhone,
    WelfareStoreHospitalAnnotationTipViewActionTypeGoto,
    WelfareStoreHospitalAnnotationTipViewActionTypeNearby
} WelfareStoreHospitalAnnotationTipViewActionType;

@class WelfareStoreHospitalAnnotationTipView;
@protocol WelfareStoreHospitalAnnotationTipViewDelegate <NSObject>
- (void)welfareStoreHospitalAnnotationTipView:(WelfareStoreHospitalAnnotationTipView *)view actionType:(WelfareStoreHospitalAnnotationTipViewActionType)type;
@end

@protocol BMKAnnotation;
@interface WelfareStoreHospitalAnnotationTipView : UITableViewCell
@property (nonatomic, strong) WelfareStoreItem *item;
@property (nonatomic, assign) id<BMKAnnotation> annotation;
@property (nonatomic, weak) id<WelfareStoreHospitalAnnotationTipViewDelegate> delegate;
@end
