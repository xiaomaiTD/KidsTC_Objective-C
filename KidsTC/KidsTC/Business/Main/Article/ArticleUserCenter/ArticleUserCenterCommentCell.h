//
//  ArticleUserCenterCommentCell.h
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleUserCenterCommentModel.h"

typedef enum : NSUInteger {
    ArticleUserCenterCommentCellActionTypePrise=1
} ArticleUserCenterCommentCellActionType;

@class ArticleUserCenterCommentCell;

@protocol ArticleUserCenterCommentCellDelegate <NSObject>
- (void)articleUserCenterCommentCell:(ArticleUserCenterCommentCell *)cell actionType:(ArticleUserCenterCommentCellActionType)type value:(id)value;
@end

@interface ArticleUserCenterCommentCell : UITableViewCell
@property (nonatomic, strong) ArticleUserCenterCommentItem *item;
@property (nonatomic, weak) id<ArticleUserCenterCommentCellDelegate> delegate;
@end
