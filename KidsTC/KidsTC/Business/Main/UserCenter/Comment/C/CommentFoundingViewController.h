//
//  CommentFoundingViewController.h
//  KidsTC
//
//  Created by Altair on 11/27/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ViewController.h"
#import "CommentFoundingModel.h"

@class CommentFoundingViewController;

@protocol CommentFoundingViewControllerDelegate <NSObject>

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc;

@end

@interface CommentFoundingViewController : ViewController

@property (nonatomic, assign) id<CommentFoundingViewControllerDelegate> delegate;

- (instancetype)initWithCommentFoundingModel:(CommentFoundingModel *)model;

@end
