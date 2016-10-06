//
//  ArticleHomeBaseCell.h
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleHomeModel.h"

typedef enum : NSUInteger {
    ArticleHomeBaseCellActionTypeSegue=1,
    ArticleHomeBaseCellActionTypeOther
} ArticleHomeBaseCellActionType;

@class ArticleHomeBaseCell;
@protocol ArticleHomeBaseCellDelegate <NSObject>
- (void)articleHomeBaseCell:(ArticleHomeBaseCell *)cell actionType:(ArticleHomeBaseCellActionType)type value:(id)value;
@end

@interface ArticleHomeBaseCell : UITableViewCell
@property (nonatomic, weak) ArticleHomeItem *item;
@property (nonatomic, weak) id<ArticleHomeBaseCellDelegate> delegate;
@end
