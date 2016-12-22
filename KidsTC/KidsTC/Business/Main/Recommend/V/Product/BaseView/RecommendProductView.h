//
//  RecommendProductView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendProduct.h"

typedef enum : NSUInteger {
    RecommendProductViewActionTypeSegue = 1,
} RecommendProductViewActionType;

@class RecommendProductView;
@protocol RecommendProductViewDelegate <NSObject>
- (void)recommendProductView:(RecommendProductView *)view actionType:(RecommendProductViewActionType)type value:(id)value;
@end

@interface RecommendProductView : UIView
@property (nonatomic, weak) id<RecommendProductViewDelegate> delegate;
@property (nonatomic, strong) NSArray<RecommendProduct *> *products;
- (void)reloadData;
- (CGFloat)contentHeight;
- (void)nilData;
@end
