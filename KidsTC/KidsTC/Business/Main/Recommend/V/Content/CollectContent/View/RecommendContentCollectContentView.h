//
//  RecommendContentCollectContentView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleHomeModel.h"

typedef enum : NSUInteger {
    RecommendContentCollectContentViewActioTypeSegue = 1,
    RecommendContentCollectContentViewActioTypeCollect,
} RecommendContentCollectContentViewActioType;

@class RecommendContentCollectContentView;
@protocol RecommendContentCollectContentViewDelegate <NSObject>
- (void)recommendContentCollectContentView:(RecommendContentCollectContentView *)view actionType:(RecommendContentCollectContentViewActioType)type value:(id)value;
@end

@interface RecommendContentCollectContentView : UIView
@property (nonatomic, strong) NSArray<ArticleHomeItem *> *contents;
@property (nonatomic, weak) id<RecommendContentCollectContentViewDelegate> delegate;
- (void)reloadData;
- (CGFloat)contentHeight;
- (void)nilData;
@end
