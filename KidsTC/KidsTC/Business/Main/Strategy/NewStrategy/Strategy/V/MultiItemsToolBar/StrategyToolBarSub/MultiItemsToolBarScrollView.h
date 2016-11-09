//
//  MultiItemsToolBarScrollView.h
//  KidsTC
//
//  Created by zhanping on 7/11/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MultiItemsToolBarScrollViewHeight 40
@class MultiItemsToolBarScrollView;
@protocol MultiItemsToolBarScrollViewDelegate <NSObject>
- (void)multiItemsToolBarScrollView:(MultiItemsToolBarScrollView *)multiItemsToolBarScrollView didSelectedIndex:(NSUInteger)index;
@end

@interface MultiItemsToolBarScrollView : UIScrollView
@property (nonatomic, strong) NSArray<NSString *> *tags;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) id<MultiItemsToolBarScrollViewDelegate> clickDelegate;
- (void)changeTipPlaceWithSmallIndex:(NSUInteger)smallIndex
                            bigIndex:(NSUInteger)bigIndex
                            progress:(CGFloat)progress
                             animate:(BOOL)animate;
@end
