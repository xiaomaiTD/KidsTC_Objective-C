//
//  UserArticleCommentsCell.h
//  KidsTC
//
//  Created by zhanping on 4/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserArticleCommentsLayout.h"
@interface ContentView : UIView
@property (nonatomic, weak) UIImageView *BGImageView;
@property (nonatomic, weak) UILabel *contentL;
@property (nonatomic, weak) UIScrollView *sv;
@property (nonatomic, weak) UIButton *priseBtn;
@property (nonatomic, weak) UILabel *priseCountL;
@property (nonatomic, copy) void (^priseBtnActionBlock)(NSString *commentSysNo);
@property (nonatomic, copy) void (^SVTapActionBlock) ();
@property (nonatomic, weak) EvaListItem *item;
@end




@interface UserArticleCommentsCell : UITableViewCell
@property (nonatomic, weak) ContentView *contentLabelView;
@property (nonatomic, weak) UILabel *articleLabel;
@property (nonatomic, weak) UIImageView *accessImageView;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, strong) UserArticleCommentsLayout *layout;
@end
