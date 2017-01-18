//
//  CommentUtilsView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CommentUtilsViewActionTypeTouchBegin = 1,
    
    CommentUtilsViewActionTypeCamera = 100,
    CommentUtilsViewActionTypePhotos,
    CommentUtilsViewActionTypeAddress,
    CommentUtilsViewActionTypeSend,
    CommentUtilsViewActionTypeSelectPicture
} CommentUtilsViewActionType;

@class CommentUtilsView;
@protocol CommentUtilsViewDelegate <NSObject>
- (void)commentUtilsView:(CommentUtilsView *)view actionType:(CommentUtilsViewActionType)type value:(id)value;
@end

@interface CommentUtilsView : UIView

@property (nonatomic, weak) id<CommentUtilsViewDelegate> delegate;

@property (nonatomic, strong) NSArray *selectedPhotos;

- (void)show:(CGFloat)margin;

- (void)hide:(void(^)(BOOL finish))completionBlock;

@end
