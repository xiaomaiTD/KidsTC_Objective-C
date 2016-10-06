//
//  CommentEditViewController.h
//  KidsTC
//
//  Created by Altair on 12/2/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ViewController.h"

@class MyCommentListItemModel;
@class CommentEditViewController;

@protocol CommentEditViewControllerDelegate <NSObject>

- (void)commentEditViewControllerDidFinishSubmitComment:(CommentEditViewController *)vc;

@end

@interface CommentEditViewController : ViewController

@property (nonatomic, assign) id<CommentEditViewControllerDelegate> delegate;

- (instancetype)initWithMyCommentItem:(MyCommentListItemModel *)item;

@end
