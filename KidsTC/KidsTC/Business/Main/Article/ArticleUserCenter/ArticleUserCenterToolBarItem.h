//
//  ArticleUserCenterToolBarItem.h
//  KidsTC
//
//  Created by zhanping on 2016/9/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ArticleUserCenterToolBarItemTypeArticle=1,
    ArticleUserCenterToolBarItemTypeComment,
} ArticleUserCenterToolBarItemType;

@class ArticleUserCenterToolBarItem;
@protocol ArticleUserCenterToolBarItemDelegate <NSObject>
- (void)articleUserCenterToolBarItem:(ArticleUserCenterToolBarItem *)item actionType:(ArticleUserCenterToolBarItemType)type;
@end

@interface ArticleUserCenterToolBarItem : UIView
@property (nonatomic, assign) ArticleUserCenterToolBarItemType type;
@property (nonatomic, weak) id<ArticleUserCenterToolBarItemDelegate> delegate;
@property (nonatomic, assign) BOOL selected;
@end
