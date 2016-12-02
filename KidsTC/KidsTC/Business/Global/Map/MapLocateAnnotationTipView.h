//
//  MapLocateAnnotationTipView.h
//  KidsTC
//
//  Created by 詹平 on 16/7/24.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MapLocateAnnotationTipViewActionTypeCancle,
    MapLocateAnnotationTipViewActionTypeSure,
} MapLocateAnnotationTipViewActionType;

@class MapLocateAnnotationTipView;
@protocol MapLocateAnnotationTipViewDelegate <NSObject>
- (void)MapLocateAnnotationTipView:(MapLocateAnnotationTipView *)view actionType:(MapLocateAnnotationTipViewActionType)type;
@end
@protocol BMKAnnotation;
@interface MapLocateAnnotationTipView : UIView
@property (nonatomic, assign) id<BMKAnnotation> annotation;
@property (nonatomic, weak) id<MapLocateAnnotationTipViewDelegate> deletate;
@end
