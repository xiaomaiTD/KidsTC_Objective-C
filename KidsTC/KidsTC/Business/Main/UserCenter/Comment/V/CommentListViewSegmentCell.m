//
//  CommentListViewSegmentCell.m
//  KidsTC
//
//  Created by 钱烨 on 7/29/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "CommentListViewSegmentCell.h"

@interface CommentListViewSegmentCell ()

@property (weak, nonatomic) IBOutlet UIView *tagView;

@end

@implementation CommentListViewSegmentCell

- (void)awakeFromNib {
    // Initialization code
    [self.tagView setHidden:YES];
    [self.contentView setBackgroundColor:COLOR_BG_CEll];
    [self.tagView setBackgroundColor:COLOR_PINK];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        [self.titleLabel setTextColor:COLOR_PINK];
        [self.countLabel setTextColor:COLOR_PINK];
        [self.tagView setHidden:NO];
    } else {
        [self.titleLabel setTextColor:[UIColor lightGrayColor]];
        [self.countLabel setTextColor:[UIColor lightGrayColor]];
        [self.tagView setHidden:YES];
    }
}

@end
