//
//  StrategyTableViewCell.h
//  KidsTC
//
//  Created by zhanping on 6/6/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrategyModel.h"
#import "StrategyLikeButton.h"

@class StrategyTableViewCell;
@protocol StrategyTableViewCellDelegate <NSObject>
- (void)strategyTableViewCell:(StrategyTableViewCell *)strategyTableViewCell didClickOnStrategyLikeButton:(StrategyLikeButton *)strategyLikeButton;
@end

@interface StrategyTableViewCell : UITableViewCell
@property (nonatomic, weak) StrategyListItem *item;
@property (weak, nonatomic) IBOutlet StrategyLikeButton *likeBtn;
@property (nonatomic, weak) id<StrategyTableViewCellDelegate> delegate;
@end
