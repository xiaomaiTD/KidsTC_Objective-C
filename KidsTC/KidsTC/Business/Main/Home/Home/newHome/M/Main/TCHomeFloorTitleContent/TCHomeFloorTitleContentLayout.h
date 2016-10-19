//
//  TCHomeFloorTitleContentLayout.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TCHomeFloorTitleContent;

#define kTCHomeFloorTitleContentH 44
#define kTCHomeFloorTitleContentW SCREEN_WIDTH

typedef enum : NSUInteger {
    TCHomeFloorTitleContentTipImageTypeNormal = 1,
    TCHomeFloorTitleContentTipImageTypeRecommend
} TCHomeFloorTitleContentTipImageType;

@interface TCHomeFloorTitleContentLayout : NSObject

@property (nonatomic, assign) CGRect tipImageViewFrame;
@property (nonatomic, assign) TCHomeFloorTitleContentTipImageType tipImageType;

@property (nonatomic, assign) CGRect titleLabelFrame;

@property (nonatomic, assign) BOOL remainLabelHidden;
@property (nonatomic, assign) CGRect remainLabelFrame;

@property (nonatomic, assign) CGRect subTitleLabelFrame;

@property (nonatomic, assign) BOOL arrowImageViewHidden;
@property (nonatomic, assign) CGRect arrowImageViewFrame;

@property (nonatomic, assign) CGRect lineFrame;
+ (instancetype)layout:(TCHomeFloorTitleContent *)titleContent;
@end
