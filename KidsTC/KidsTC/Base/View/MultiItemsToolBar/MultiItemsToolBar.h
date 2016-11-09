//
//  MultiItemsToolBar.h
//  KidsTC
//
//  Created by zhanping on 7/11/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MultiItemsToolBarScrollView.h"
@class MultiItemsToolBar;
@protocol MultiItemsToolBarDelegate <NSObject>
- (void)multiItemsToolBar:(MultiItemsToolBar *)multiItemsToolBar didSelectedIndex:(NSUInteger)index;
@end

@interface MultiItemsToolBar : UIView
@property (nonatomic, strong) NSArray<NSString *> *tags;
@property (nonatomic, weak) id<MultiItemsToolBarDelegate> delegate;
- (void)changeTipPlaceWithSmallIndex:(NSUInteger)smallIndex
                            bigIndex:(NSUInteger)bigIndex
                            progress:(CGFloat)progress
                             animate:(BOOL)animate;
@end
