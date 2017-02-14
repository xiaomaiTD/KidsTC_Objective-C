//
//  ScoreEarnView.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScoreUserInfoData.h"
#import "ScoreOrderItem.h"
#import "ScoreProductData.h"

typedef enum : NSUInteger {
    ScoreEarnViewActionTypeLoadData = 1,
    
    ScoreEarnViewActionTypePlant = 50,
    ScoreEarnViewActionTypeExchange,
    ScoreEarnViewActionTypeOrderDetail,
    ScoreEarnViewActionTypeContact,
    ScoreEarnViewActionTypeComment,
    ScoreEarnViewActionTypeSegue,
    
} ScoreEarnViewActionType;
@class ScoreEarnView;
@protocol ScoreEarnViewDelegate <NSObject>
- (void)scoreEarnView:(ScoreEarnView *)view actionType:(ScoreEarnViewActionType)type value:(id)value;
@end

@interface ScoreEarnView : UIView
@property (nonatomic,  weak) id<ScoreEarnViewDelegate> delegate;
@property (nonatomic,assign) BOOL isLoadProducts;

@property (nonatomic,strong) ScoreUserInfoData *userInfoData;
@property (nonatomic,strong) NSArray<ScoreOrderItem *> *orderItems;
@property (nonatomic,strong) ScoreProductData *productData;

- (void)dealWithUI:(NSUInteger)loadCount isComment:(BOOL)isComment;
- (void)reloadData;

@end
