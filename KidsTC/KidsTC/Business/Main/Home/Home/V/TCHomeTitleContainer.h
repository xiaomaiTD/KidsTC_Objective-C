//
//  TCHomeTitleContainer.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCHomeFloorTitleContent.h"

typedef enum : NSUInteger {
    TCHomeTitleContainerActionTypeSegue,
} TCHomeTitleContainerActionType;

@class TCHomeTitleContainer;
@protocol TCHomeTitleContainerDelegate <NSObject>
- (void)tcHomeTitleContainer:(TCHomeTitleContainer *)container actionType:(TCHomeTitleContainerActionType)type value:(id)value;
@end

@interface TCHomeTitleContainer : UIView
@property (nonatomic, strong) TCHomeFloorTitleContent *titleContent;
@property (nonatomic, weak) id<TCHomeTitleContainerDelegate> delegate;
@end
