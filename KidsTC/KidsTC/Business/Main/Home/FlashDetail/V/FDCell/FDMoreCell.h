//
//  FDMoreCell.h
//  KidsTC
//
//  Created by zhanping on 5/19/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDSegmentView.h"
@interface FDMoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *moreCommentsBtn;
@property (weak, nonatomic) IBOutlet UIView *noCommentsView;
@property (nonatomic, copy) void (^showMoreCommentBlock)();
- (void)configWithCurrentType:(FDSegmentViewBtnType)type cellCount:(NSUInteger)count;
@end
