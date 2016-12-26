//
//  RecommendTarentoCollectTarentoView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendTarento.h"

typedef enum : NSUInteger {
    RecommendTarentoCollectTarentoViewActionTypeUserArticleCenter = 1,
    RecommendTarentoCollectTarentoViewActionTypeCollect,
    RecommendTarentoCollectTarentoViewActionTypeSegue,
} RecommendTarentoCollectTarentoViewActionType;

@class RecommendTarentoCollectTarentoView;
@protocol RecommendTarentoCollectTarentoViewDelegate <NSObject>
- (void)recommendTarentoCollectTarentoView:(RecommendTarentoCollectTarentoView *)view actionType:(RecommendTarentoCollectTarentoViewActionType)type value:(id)value;
@end

@interface RecommendTarentoCollectTarentoView : UIView
@property (nonatomic, strong) NSArray<RecommendTarento *> *tarentos;
@property (nonatomic, weak) id<RecommendTarentoCollectTarentoViewDelegate> delegate;
- (void)reloadData;
- (CGFloat)contentHeight;
- (void)nilData;
@end
