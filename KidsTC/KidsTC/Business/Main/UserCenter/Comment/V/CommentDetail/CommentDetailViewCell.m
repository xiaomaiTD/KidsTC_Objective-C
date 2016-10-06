//
//  CommentDetailViewCell.m
//  KidsTC
//
//  Created by 钱烨 on 10/27/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "CommentDetailViewCell.h"
#import "UIButton+Category.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface CommentDetailViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConsTraintHeight;

- (IBAction)didClickedReplyButton:(id)sender;

@end

@implementation CommentDetailViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    [self.replyButton setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    self.replyButton.layer.cornerRadius = 5;
    self.replyButton.layer.masksToBounds = YES;
    
    self.cellImageView.layer.cornerRadius = 30;
    self.cellImageView.layer.masksToBounds = YES;
    self.HLineConsTraintHeight.constant = LINE_H;
    
    self.replyButton.userInteractionEnabled = NO;
}

- (void)configWithModel:(CommentReplyItemModel *)model {
    if (model) {
        //face image
        [self.cellImageView sd_setImageWithURL:model.faceImageUrl placeholderImage:PLACEHOLDERIMAGE_SMALL];
        //content
        NSString *wholeString = [NSString stringWithFormat:@"%@：%@", model.userName, model.replyContent];
        NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:wholeString];
        NSDictionary *attribute = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:15] forKey:NSFontAttributeName];
        [labelString setAttributes:attribute range:NSMakeRange(0, [model.userName length] + 1)];
        [self.contentLabel setAttributedText:labelString];
        //time
        [self.timeLabel setText:model.timeDescription];
    }
}

- (IBAction)didClickedReplyButton:(id)sender {
}
@end
