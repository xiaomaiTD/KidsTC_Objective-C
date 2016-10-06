//
//  ArticleCommentCell.h
//  KidsTC
//
//  Created by zhanping on 4/26/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleCommentLayout.h"
#import "TTTAttributedLabel.h"

@interface ArticleCommentCell : UITableViewCell<TTTAttributedLabelDelegate>
@property (nonatomic, weak) UIImageView *headImgaView;
@property (nonatomic, weak) UILabel *namesLabel;
@property (nonatomic, weak) UILabel *priseCountLabel;
@property (nonatomic, weak) UIButton *priseBtn;

@property (nonatomic, weak) TTTAttributedLabel *contentLabel;
@property (nonatomic, weak) UIButton *styleBtn;
@property (nonatomic, weak) UIScrollView *sv;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, strong) ArticleCommentLayout *layout;

@property (nonatomic, copy) void (^headActionBlock) (NSString *userId);
@property (nonatomic, copy) void (^nameActionBlock) (NSString *userId);
@property (nonatomic, copy) void (^changeStyleActionBlock)();
@property (nonatomic, copy) void (^priseActionBlock) (NSString *userId);
@property (nonatomic, copy) void (^SVTapActionBlock) ();

@end
