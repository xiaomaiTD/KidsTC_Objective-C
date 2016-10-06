//
//  ArticleWriteContentCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleWriteContentCell.h"
#import "ArticleWriteTextLinePositionModifier.h"

@interface ArticleWriteContentCell ()<YYTextViewDelegate>
@property (weak, nonatomic) IBOutlet YYTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tfConstraintHeight;

@end

@implementation ArticleWriteContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _textView.delegate = self;
    _textView.textContainerInset = UIEdgeInsetsMake(12, 12, 12, 12);
    _textView.extraAccessoryViewHeight = kBottomHeight;
    _textView.bounces = NO;
    _textView.scrollEnabled = NO;
    
    ArticleWriteTextLinePositionModifier *modifier = [ArticleWriteTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:17];
    modifier.paddingTop = 12;
    modifier.paddingBottom = 12;
    modifier.lineHeightMultiple = 1.5;
    _textView.linePositionModifier = modifier;
}

- (void)setModel:(ArticleWriteModel *)model {
    [super setModel:model];
    
    _textView.font = model.font;
    _textView.placeholderAttributedText = model.place;
    _textView.attributedText = model.words;
    
    CGFloat height = _textView.contentSize.height;
    height = height>43?height:43;
    if (height != self.tfConstraintHeight.constant) {
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
        self.tfConstraintHeight.constant = height;
        [_textView setNeedsLayout];
        [_textView layoutIfNeeded];
    }
}

#pragma mark - YYTextViewDelegate

- (void)textViewDidBeginEditing:(YYTextView *)textView{
    if ([self.delegate respondsToSelector:@selector(articleWriteBaseCell:actionType:value:)]) {
        [self.delegate articleWriteBaseCell:self actionType:ArticleWriteBaseCellActionTypeTextViewDidBeginEditing value:nil];
    }
}

- (void)textViewDidChange:(YYTextView *)textView {
    
    if (![textView isFirstResponder]) return;
    
    self.model.words = textView.attributedText;
    
    CGFloat height = textView.contentSize.height;
    height = height>43?height:43;
    
    if (height != self.tfConstraintHeight.constant) {
        
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
        
        CGFloat space = height - self.tfConstraintHeight.constant;
        
        self.tfConstraintHeight.constant = height;
        [_textView setNeedsLayout];
        [_textView layoutIfNeeded];
        
        if ([self.delegate respondsToSelector:@selector(articleWriteBaseCell:actionType:value:)]) {
            [self.delegate articleWriteBaseCell:self actionType:ArticleWriteBaseCellActionTypeTextViewDidChange value:@(space)];
        }
    }
}

- (void)textViewDidEndEditing:(YYTextView *)textView {
    if ([self.delegate respondsToSelector:@selector(articleWriteBaseCell:actionType:value:)]) {
        [self.delegate articleWriteBaseCell:self actionType:ArticleWriteBaseCellActionTypeTextViewDidEndEditing value:nil];
    }
}


@end
