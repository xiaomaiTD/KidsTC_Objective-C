//
//  CommentDetailViewStrategyHeaderCell.m
//  KidsTC
//
//  Created by 钱烨 on 10/27/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "CommentDetailViewStrategyHeaderCell.h"
#import "ParentingStrategyDetailModel.h"
#import "TTTAttributedLabel.h"
#import "UIButton+Category.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"

@interface CommentDetailViewStrategyHeaderCell () <TTTAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *cellBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timeTagImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *relatedInfoButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoHeight;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

- (IBAction)didClickedRelatedInfoButton:(id)sender;
- (IBAction)didClickedCommentButton:(id)sender;

@end

@implementation CommentDetailViewStrategyHeaderCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:COLOR_BG_CEll];
    
    self.shadowView.layer.cornerRadius = 10;
    self.shadowView.layer.masksToBounds = YES;
    
    [self.cellBGView setBackgroundColor:COLOR_BG_CEll];
    self.cellBGView.layer.cornerRadius = 10;
    self.cellBGView.layer.masksToBounds = YES;
    
    [self.relatedInfoButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.relatedInfoButton setBackgroundColor:COLOR_PINK forState:UIControlStateSelected];
    self.relatedInfoButton.layer.cornerRadius = 10;
    self.relatedInfoButton.layer.masksToBounds = YES;
    
    self.contentLabel.delegate = self;
    [self.contentLabel setLinkAttributes:nil];
}

- (void)configWithDetailCellModel:(ParentingStrategyDetailCellModel *)cellModel {
    if (cellModel) {
        //image
        self.imageHeight.constant = cellModel.ratio * (SCREEN_WIDTH - 20);
        [self.cellImageView sd_setImageWithURL:cellModel.imageUrl];
        //content
        NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:cellModel.cellContentString];
        NSDictionary *fontAttribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, [UIColor darkGrayColor], NSForegroundColorAttributeName, nil];
        [labelString setAttributes:fontAttribute range:NSMakeRange(0, [labelString length])];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8];//调整行间距
        [labelString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelString length])];        if (cellModel.contentSegueModels) {
            for (TextSegueModel *model in cellModel.contentSegueModels) {
                //[NSNumber numberWithBool:YES], NSUnderlineStyleAttributeName
                NSDictionary *linkAttribute = [NSDictionary dictionaryWithObjectsAndKeys:model.linkColor, NSForegroundColorAttributeName, nil];
                for (NSString *rangeString in model.linkRangeStrings) {
                    NSRange range = NSRangeFromString(rangeString);
                    [labelString addAttributes:linkAttribute range:range];
                    [self.contentLabel addLinkToAddress:[NSDictionary dictionaryWithObject:model forKey:@"promotionSegueModel"] withRange:range];
                }
            }
        }
        [self.contentLabel setAttributedText:labelString];
        //time
        if ([cellModel.timeDescription length] > 0) {
            [self.timeTagImageView setHidden:NO];
            [self.timeLabel setHidden:NO];
            [self.timeLabel setText:cellModel.timeDescription];
        } else {
            [self.timeTagImageView setHidden:YES];
            [self.timeLabel setHidden:YES];
        }
        //related
        if (cellModel.relatedInfoModel && [cellModel.relatedInfoTitle length] > 0) {
            [self.relatedInfoButton setHidden:NO];
            [self.relatedInfoButton setTitle:cellModel.relatedInfoTitle forState:UIControlStateNormal];
        } else {
            [self.relatedInfoButton setHidden:YES];
        }
        if ([self.timeLabel isHidden] && [self.relatedInfoButton isHidden]) {
            self.infoHeight.constant = 0;
        } else {
            self.infoHeight.constant = 40;
        }
        //comment
        NSString *commentTitle = @"";
        if (cellModel.commentCount > 99) {
            commentTitle = @" 99+";
        } else {
            commentTitle = [NSString stringWithFormat:@" %lu", (unsigned long)cellModel.commentCount];
        }
        [self.commentButton setTitle:commentTitle forState:UIControlStateNormal];
    }
}

- (IBAction)didClickedRelatedInfoButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedRelatedInfoButtonOnCommentDetailViewStrategyHeaderCell:)]) {
        [self.delegate didClickedRelatedInfoButtonOnCommentDetailViewStrategyHeaderCell:self];
    }
}

- (IBAction)didClickedCommentButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedCommentButtonOnCommentDetailViewStrategyHeaderCell:)]) {
        [self.delegate didClickedCommentButtonOnCommentDetailViewStrategyHeaderCell:self];
    }
}

#pragma mark TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents {
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentDetailViewStrategyHeaderCell:didSelectedLinkWithSegueModel:)]) {
        TextSegueModel *model = [addressComponents objectForKey:@"promotionSegueModel"];
        [self.delegate commentDetailViewStrategyHeaderCell:self didSelectedLinkWithSegueModel:model.segueModel];
    }
}

@end
