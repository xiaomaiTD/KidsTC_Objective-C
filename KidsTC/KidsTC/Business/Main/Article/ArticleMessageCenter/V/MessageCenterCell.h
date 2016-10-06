//
//  MessageCenterCell.h
//  KidsTC
//
//  Created by zhanping on 4/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCenterLayout.h"
#import "TTTAttributedLabel.h"

@interface MCArticelView : UIView
@property (nonatomic, weak) UILabel *articleLabel;
@property (nonatomic, weak) UIImageView *articleImageView;
@property (nonatomic, copy) void (^articleTapAction) ();
@end

@interface MessageCenterCell : UITableViewCell<TTTAttributedLabelDelegate>
@property (nonatomic, weak) UIImageView *headImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) TTTAttributedLabel *contentLabel;
@property (nonatomic, weak) MCArticelView *articleView;
@property (nonatomic, weak) UIView *line;

@property (nonatomic, strong) MessageCenterLayout *layout;

@property (nonatomic, copy) void (^meTapAction)();
@property (nonatomic, copy) void (^otherUserTapAction) ();

@end
