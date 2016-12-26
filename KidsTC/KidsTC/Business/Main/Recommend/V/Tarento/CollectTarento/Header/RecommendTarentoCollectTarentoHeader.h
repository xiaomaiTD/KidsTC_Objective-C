//
//  RecommendTarentoCollectTarentoHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendTarento.h"

typedef enum : NSUInteger {
    RecommendTarentoCollectTarentoHeaderActionTypeUserArticleCenter = 1,
    RecommendTarentoCollectTarentoHeaderActionTypeCollect,
} RecommendTarentoCollectTarentoHeaderActionType;

@class RecommendTarentoCollectTarentoHeader;
@protocol RecommendTarentoCollectTarentoHeaderDelegate <NSObject>
- (void)recommendTarentoCollectTarentoHeader:(RecommendTarentoCollectTarentoHeader *)header actionType:(RecommendTarentoCollectTarentoHeaderActionType)type value:(id)value;
@end

@interface RecommendTarentoCollectTarentoHeader : UITableViewHeaderFooterView
@property (nonatomic, strong) RecommendTarento *tarento;
@property (nonatomic, weak) id<RecommendTarentoCollectTarentoHeaderDelegate> delegate;
@end
