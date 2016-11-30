//
//  MyTracksView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MyTracksPageCount 10

typedef enum : NSUInteger {
    MyTracksViewActionTypeLoadData = 1,
    MyTracksViewActionTypeSegue,
    MyTracksViewActionTypeDelete,
} MyTracksViewActionType;

@class MyTracksView;
@protocol MyTracksViewDelegate <NSObject>
- (void)myTracksView:(MyTracksView *)view actionType:(MyTracksViewActionType)type value:(id)value completion:(void(^)(id value))completion;
@end

@interface MyTracksView : UIView
@property (nonatomic, weak) id<MyTracksViewDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
- (void)dealWithUI:(NSUInteger)loadCount;
- (void)edit:(BOOL)edit;
@end
