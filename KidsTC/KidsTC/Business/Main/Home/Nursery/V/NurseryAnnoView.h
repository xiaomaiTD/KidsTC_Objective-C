//
//  NurseryAnnoView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NurseryItem.h"

typedef enum : NSUInteger {
    NurseryAnnoViewActionTypeNearby,
    NurseryAnnoViewActionTypeRoute,
} NurseryAnnoViewActionType;

@class NurseryAnnoView;
@protocol NurseryAnnoViewDelegate <NSObject>
- (void)nurseryAnnoView:(NurseryAnnoView *)view actionType:(NurseryAnnoViewActionType)type value:(id)value;
@end

@protocol BMKAnnotation;
@interface NurseryAnnoView : UIView
@property (nonatomic, strong) NurseryItem *item;
@property (nonatomic, assign) id<BMKAnnotation> annotation;
@property (nonatomic, weak) id<NurseryAnnoViewDelegate> delegate;
@end
