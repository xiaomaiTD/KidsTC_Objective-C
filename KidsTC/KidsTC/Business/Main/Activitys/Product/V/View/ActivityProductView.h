//
//  ActivityProductView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityProductData.h"

typedef enum : NSUInteger {
    ActivityProductViewActionTypeSegue = 1,
    ActivityProductViewActionType2,
    
} ActivityProductViewActionType;

@class ActivityProductView;
@protocol ActivityProductViewDelegate <NSObject>
- (void)activityProductView:(ActivityProductView *)view actionType:(ActivityProductViewActionType)type value:(id)value;
@end

@interface ActivityProductView : UIView
@property (nonatomic, weak) id<ActivityProductViewDelegate> delegate;
@property (nonatomic, strong) ActivityProductData *data;
@end
