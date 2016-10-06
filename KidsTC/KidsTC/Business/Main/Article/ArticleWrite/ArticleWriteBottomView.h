//
//  ArticleWriteBottomView.h
//  KidsTC
//
//  Created by zhanping on 9/8/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ArticleWriteBottomViewActionTypePicture=1,
    ArticleWriteBottomViewActionTypePreview
} ArticleWriteBottomViewActionType;

@class ArticleWriteBottomView;
@protocol ArticleWriteBottomViewDelegate <NSObject>
- (void)articleWriteBottomView:(ArticleWriteBottomView *)view actionType:(ArticleWriteBottomViewActionType)type;
@end

@interface ArticleWriteBottomView : UIView
@property (nonatomic, weak) id<ArticleWriteBottomViewDelegate> delegate;
@end
