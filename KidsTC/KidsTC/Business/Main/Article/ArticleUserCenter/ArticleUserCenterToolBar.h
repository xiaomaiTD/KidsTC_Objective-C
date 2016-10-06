//
//  ArticleUserCenterToolBar.h
//  KidsTC
//
//  Created by zhanping on 2016/9/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleUserCenterToolBarItem.h"

extern int const kArticleUserCenterToolBarHeight;

@class ArticleUserCenterToolBar;
@protocol ArticleUserCenterToolBarDelegate <NSObject>
- (void)articleUserCenterToolBar:(ArticleUserCenterToolBar *)toolBar currentType:(ArticleUserCenterToolBarItemType)type;
@end

@interface ArticleUserCenterToolBar : UIView
@property (nonatomic, weak) id<ArticleUserCenterToolBarDelegate> delegate;
- (void)beginRefreshing;
@end
