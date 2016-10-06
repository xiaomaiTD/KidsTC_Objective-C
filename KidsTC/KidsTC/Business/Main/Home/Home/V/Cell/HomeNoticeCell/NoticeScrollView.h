//
//  NoticeScrollView.h
//  KidsTC
//
//  Created by 潘灵 on 16/7/21.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AUINoticeViewPlayDirectionLeftToRight,
    AUINoticeViewPlayDirectionRightToLeft,
    AUINoticeViewPlayDirectionTopToBottom,
    AUINoticeViewPlayDirectionBottomToTop
}NoticeViewPlayDirection;

@class NoticeScrollView;

@protocol NoticeViewDataSource <NSObject>

- (NSUInteger)numberOfStringsForNoticeView:(NoticeScrollView *)noticeView;

- (NSString *)noticeStringForNoticeView:(NoticeScrollView *)noticeView atIndex:(NSUInteger)index;

- (CGSize)sizeForNoticeView:(NoticeScrollView *)noticeView;

@end

@protocol NoticeViewDelegate <NSObject>

@optional

- (void)NoticeView:(NoticeScrollView *)noticeView didScrolledToIndex:(NSUInteger)index;

- (void)NoticeView:(NoticeScrollView *)noticeView didClickedAtIndex:(NSUInteger)index;

@end

@interface NoticeScrollView : UIView

@property (nonatomic, assign) id<NoticeViewDataSource> dataSource;

@property (nonatomic, assign) id<NoticeViewDelegate> delegate;

@property (nonatomic, assign) NSUInteger maxLine; //default 1

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) BOOL enableClicking;

@property (nonatomic, assign) NSUInteger autoPlayDuration; //0 means no auto play, default is 3

@property (nonatomic, assign) NoticeViewPlayDirection playDirection;

- (void)reloadData;


@end
