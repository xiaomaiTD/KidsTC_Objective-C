//
//  CommentUtilsToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const animationDuration;

typedef enum : NSUInteger {
    CommentUtilsToolBarActionTypeCamera = 100,
    CommentUtilsToolBarActionTypePhotos,
    CommentUtilsToolBarActionTypeAddress,
    CommentUtilsToolBarActionTypeSend,
    CommentUtilsToolBarActionTypeSelectPicture,
} CommentUtilsToolBarActionType;

@class CommentUtilsToolBar;
@protocol CommentUtilsToolBarDelegate <NSObject>
- (void)commentUtilsToolBar:(CommentUtilsToolBar *)toolBar actionType:(CommentUtilsToolBarActionType)type value:(id)value;
@end

@interface CommentUtilsToolBar : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, weak) id<CommentUtilsToolBarDelegate> delegate;
@property (nonatomic, strong) NSArray *selectedPhotos;

@end
