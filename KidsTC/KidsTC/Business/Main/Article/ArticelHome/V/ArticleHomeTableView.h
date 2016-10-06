//
//  ArticleHomeTableView.h
//  KidsTC
//
//  Created by zhanping on 9/5/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleHomeModel.h"

typedef enum : NSUInteger {
    ArticleHomeTableViewActionTypeLoadData=1,
    ArticleHomeTableViewActionTypeMakeSegue,
    ArticleHomeTableViewActionTypeDidScroll
} ArticleHomeTableViewActionType;

@class ArticleHomeTableView;
@protocol ArticleHomeTableViewDelegate <NSObject>
- (void)articleHomeTableView:(ArticleHomeTableView *)tableView actionType:(ArticleHomeTableViewActionType)type value:(id)value;
@end

@interface ArticleHomeTableView : UITableView
@property (nonatomic, strong) NSArray<NSArray<ArticleHomeItem *> *> *sections;
@property (nonatomic, weak) id<ArticleHomeTableViewDelegate> cDelegate;
- (void)beginRefreshing;
- (void)endRefresh;
- (void)noMoreData;
@end
