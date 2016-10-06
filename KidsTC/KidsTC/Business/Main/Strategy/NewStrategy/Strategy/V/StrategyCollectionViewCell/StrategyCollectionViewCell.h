//
//  StrategyCollectionViewCell.h
//  KidsTC
//
//  Created by zhanping on 6/6/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrategyModel.h"
#import "StrategyTableHeaderView.h"
#import "StrategyTableViewCell.h"
@class StrategyCollectionViewCell;
@protocol StrategyCollectionViewCellDelegate <NSObject>
- (void)strategyCell:(StrategyCollectionViewCell *)strategyCell loadDataRefresh:(BOOL)refresh;
- (void)strategyCell:(StrategyCollectionViewCell *)strategyCell tableView:(UITableView *)tableView didSelectedIndexPath:(NSIndexPath *)indexPath;
- (void)strategyCell:(StrategyCollectionViewCell *)strategyCell strategyTableViewCell:(StrategyTableViewCell *)strategyTableViewCell didClickOnStrategyLikeButton:(StrategyLikeButton *)strategyLikeButton;
- (void)strategyCell:(StrategyCollectionViewCell *)strategyCell strategyTableHeaderView:(StrategyTableHeaderView *)strategyTableHeaderView didClickBannerAtIndex:(NSUInteger)index;
- (void)strategyCell:(StrategyCollectionViewCell *)strategyCell strategyTableHeaderView:(StrategyTableHeaderView *)strategyTableHeaderView didClickTagPicAtIndex:(NSUInteger)index;
@end

@interface StrategyCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) StrategyShowModel *model;
@property (nonatomic, assign) UIEdgeInsets tableViewInset;
@property (nonatomic, weak) id<StrategyCollectionViewCellDelegate> delegate;
- (void)reloadData;
- (void)beginRefreshing;
- (void)headerEndRefreshing;
- (void)footerEndRefreshing;
- (void)footerEndRefreshingWithNoMoreData;

@end
