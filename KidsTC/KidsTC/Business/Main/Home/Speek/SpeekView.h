//
//  SpeekView.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SpeekViewActionTypeRecognizeSuccess = 1
} SpeekViewActionType;

@class SpeekView;
@protocol SpeekViewDelegate <NSObject>
- (void)speekView:(SpeekView *)view actionTyp:(SpeekViewActionType)type value:(id)value;
@end

@interface SpeekView : UIView
@property (nonatomic, weak) id<SpeekViewDelegate> delegate;
- (void)viewWillAppear;
- (void)viewWillDisappear;
- (void)start;
@end
