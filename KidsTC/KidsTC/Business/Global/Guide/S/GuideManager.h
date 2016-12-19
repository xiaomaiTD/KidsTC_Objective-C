//
//  GuideManager.h
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuideModel.h"
#import "Single.h"
#import "GuideViewController.h"

typedef enum : NSUInteger {
    GuideTypeHome,
    GuideTypeArticle,
    GuideTypeNearby,
    GuideTypeOrderDetail,
    GuideTypeProductDetail
} GuideType;

extern NSString *const kHomeGuideViewControllerFinishShow;
extern NSString *const kArticleGuideViewControllerFinishShow;
extern NSString *const kNearbyGuideViewControllerFinishShow;
extern NSString *const kOrderDetailGuideViewControllerFinishShow;
extern NSString *const kProductDetailGuideViewControllerFinishShow;

@interface GuideManager : NSObject
singleH(GuideManager)
/**
 *  检查是否需要展示引导页
 *
 *  @param target      当前控制器
 *  @param type        引导页的类型
 *  @param resultBlock 展示完引导页面后的回调
 */
- (void)checkGuideWithTarget:(UIViewController *)target
                        type:(GuideType)type
                 resultBlock:(void(^)())resultBlock;
@end
