//
//  CommentUtilsViewController.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/17.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ViewController.h"
@class CommentUtilsViewController;
@protocol CommentUtilsViewControllerDelegate <NSObject>
- (void)commentUtilsViewController:(CommentUtilsViewController *)controller didClickSendWithPhotos:(NSArray *)photos text:(NSString *)text;
@end

@interface CommentUtilsViewController : ViewController
@property (nonatomic, weak) id<CommentUtilsViewControllerDelegate> delegate;
@end
