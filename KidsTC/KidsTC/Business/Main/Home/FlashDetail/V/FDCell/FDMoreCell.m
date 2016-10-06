//
//  FDMoreCell.m
//  KidsTC
//
//  Created by zhanping on 5/19/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FDMoreCell.h"
@interface FDMoreCell ()


@end
@implementation FDMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moreCommentsBtn.layer.cornerRadius = 4;
    self.moreCommentsBtn.layer.masksToBounds = YES;
    self.moreCommentsBtn.layer.borderWidth = LINE_H;
    self.moreCommentsBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setShowMoreCommentBlock:(void (^)())showMoreCommentBlock{
    if (!_showMoreCommentBlock) {
        _showMoreCommentBlock = showMoreCommentBlock;
    }
}

- (IBAction)showMoreCommentsAction:(UIButton *)sender {
    if (self.showMoreCommentBlock) {
        self.showMoreCommentBlock();
    }
}

- (void)configWithCurrentType:(FDSegmentViewBtnType)type cellCount:(NSUInteger)count{
    if (type != FDSegmentViewBtnType_Comment) {
        self.moreCommentsBtn.hidden = YES;
        self.noCommentsView.hidden = YES;
    }else{
        if (count==0) {
            self.moreCommentsBtn.hidden = YES;
            self.noCommentsView.hidden = NO;
        }else{
            self.moreCommentsBtn.hidden = NO;
            self.noCommentsView.hidden = YES;
        }
    }
}

@end
