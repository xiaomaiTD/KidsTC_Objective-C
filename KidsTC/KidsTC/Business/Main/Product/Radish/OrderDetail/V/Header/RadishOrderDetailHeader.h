//
//  RadishOrderDetailHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RadishOrderDetailHeaderActionTypeClose = 1,
    RadishOrderDetailHeaderActionTypeShowRule,
} RadishOrderDetailHeaderActionType;

@class RadishOrderDetailHeader;
@protocol RadishOrderDetailHeaderDelegate <NSObject>
- (void)radishOrderDetailHeader:(RadishOrderDetailHeader *)header actionType:(RadishOrderDetailHeaderActionType)type;
@end

@interface RadishOrderDetailHeader : UIView
@property (nonatomic, assign) id<RadishOrderDetailHeaderDelegate> delegate;
@end
