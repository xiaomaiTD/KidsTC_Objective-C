//
//  BannerScrollView.h
//  KidsTC
//
//  Created by 潘灵 on 16/7/20.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BannerScrollView;

@protocol BannerScrollViewDataSource <NSObject>

- (NSUInteger)numberOfBannersOnScrollView:(BannerScrollView *)scrollView;

- (UIImageView *)bannerImageViewOnScrollView:(BannerScrollView *)scrollView withViewFrame:(CGRect)frame atIndex:(NSUInteger)index;

- (CGFloat)heightForBannerScrollView:(BannerScrollView *)scrollView;

@optional

//for recyclable
- (UIImage *)bannerImageForScrollView:(BannerScrollView *)scrollView atIndex:(NSUInteger)index;

//for recyclable
- (NSURL *)bannerImageUrlForScrollView:(BannerScrollView *)scrollView atIndex:(NSUInteger)index;

@end

@protocol BannerScrollViewDelegate <NSObject>

@optional

- (void)BannerScrollView:(BannerScrollView *)scrollView didScrolledToIndex:(NSUInteger)index;

- (void)BannerScrollView:(BannerScrollView *)scrollView didClickedAtIndex:(NSUInteger)index;

@end

@interface BannerScrollView : UIView

@property (nonatomic, assign) id<BannerScrollViewDataSource> dataSource;

@property (nonatomic, assign) id<BannerScrollViewDelegate> delegate;

@property (nonatomic, assign) BOOL enableClicking;

@property (nonatomic, assign) BOOL showPageIndex; //default YES

@property (nonatomic, assign) NSUInteger autoPlayDuration; //0 means no auto play, default is 0

@property (nonatomic, assign) BOOL recyclable;

- (void)reloadData;
@end
