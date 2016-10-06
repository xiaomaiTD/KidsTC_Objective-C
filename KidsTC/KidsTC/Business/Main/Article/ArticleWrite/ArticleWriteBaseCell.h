//
//  ArticleWriteBaseCell.h
//  KidsTC
//
//  Created by zhanping on 9/8/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YYKit.h"
#import "ArticleWriteModel.h"

extern int const kBottomHeight;

typedef enum : NSUInteger {
    ArticleWriteBaseCellActionTypeSelectClass=1,
    ArticleWriteBaseCellActionTypeSelectCover,
    ArticleWriteBaseCellActionTypeDeletContentImage,
    ArticleWriteBaseCellActionTypeTextViewDidBeginEditing,
    ArticleWriteBaseCellActionTypeTextViewDidChange,
    ArticleWriteBaseCellActionTypeTextViewDidEndEditing
} ArticleWriteBaseCellActionType;

@class ArticleWriteBaseCell;
@protocol ArticleWriteBaseCellDelegate <NSObject>
- (void)articleWriteBaseCell:(ArticleWriteBaseCell *)cell actionType:(ArticleWriteBaseCellActionType)type value:(id)value;
@end
@class ArticleHomeClassItem;
@interface ArticleWriteBaseCell : UITableViewCell
@property (nonatomic, strong) NSArray<ArticleHomeClassItem *> *classes;
@property (nonatomic,strong) ArticleWriteModel *model;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,weak) id<ArticleWriteBaseCellDelegate> delegate;
@end
