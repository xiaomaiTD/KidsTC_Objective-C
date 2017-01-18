//
//  CommentUtilsView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "CommentUtilsView.h"
#import "CommentUtilsToolBar.h"

@interface CommentUtilsView ()<CommentUtilsToolBarDelegate>
@property (weak, nonatomic) IBOutlet CommentUtilsToolBar *toolBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomMargin;

@end

@implementation CommentUtilsView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.toolBar.delegate = self;
    
    self.backgroundColor = [UIColor clearColor];
    self.toolBarBottomMargin.constant = -CGRectGetHeight(self.toolBar.bounds);
    [self layoutIfNeeded];
}

- (void)setSelectedPhotos:(NSArray *)selectedPhotos {
    _selectedPhotos = selectedPhotos;
    self.toolBar.selectedPhotos = self.selectedPhotos;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(commentUtilsView:actionType:value:)]) {
        [self.delegate commentUtilsView:self actionType:CommentUtilsViewActionTypeTouchBegin value:self.toolBar.textView.text];
    }
}

- (void)show:(CGFloat)margin {
    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.toolBarBottomMargin.constant = margin;
        [self layoutIfNeeded];
    }];
}

- (void)hide:(void(^)(BOOL finish))completionBlock {
    [UIView animateWithDuration:animationDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.toolBarBottomMargin.constant = -CGRectGetHeight(self.toolBar.bounds);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completionBlock)completionBlock(finished);
    }];
}

#pragma mark - CommentUtilsToolBarDelegate

- (void)commentUtilsToolBar:(CommentUtilsToolBar *)toolBar actionType:(CommentUtilsToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(commentUtilsView:actionType:value:)]) {
        [self.delegate commentUtilsView:self actionType:(CommentUtilsViewActionType)type value:value];
    }
}

@end
