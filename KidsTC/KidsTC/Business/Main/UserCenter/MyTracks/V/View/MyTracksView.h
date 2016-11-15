//
//  MyTracksView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MyTracksViewActionTypeLoadData = 1,
} MyTracksViewActionType;

@class MyTracksView;
@protocol MyTracksViewDelegate <NSObject>
- (void)myTracksView:(MyTracksView *)view actionType:(MyTracksViewActionType)type value:(id)value;
@end

@interface MyTracksView : UIView
@property (nonatomic, weak) id<MyTracksViewDelegate> delegate;
- (void)endRefresh:(BOOL)noMoreData;
@end
