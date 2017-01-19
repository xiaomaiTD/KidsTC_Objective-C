//
//  OrderRefundView.m
//  KidsTC
//
//  Created by Altair on 11/28/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "OrderRefundView.h"
#import "RichPriceView.h"
#import "PlaceHolderTextView.h"
#import "StepperView.h"
#import "ToolBox.h"
#import "UIButton+Category.h"


#define MAXREASONLENGTH (200)

@interface OrderRefundView () <UITextViewDelegate, StepperDelegate>

@property (weak, nonatomic) IBOutlet UIView *countBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countBGHeight;
@property (weak, nonatomic) IBOutlet StepperView *stepperView;
@property (weak, nonatomic) IBOutlet RichPriceView *refundAmountView;
@property (weak, nonatomic) IBOutlet UILabel *backPointNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *reasonButton;
@property (weak, nonatomic) IBOutlet PlaceHolderTextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *radishTipL;
@property (weak, nonatomic) IBOutlet UILabel *radishCountL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipTopMargin;
@property (nonatomic, strong) OrderRefundModel *refundModel;

- (IBAction)didClickedReasonButton:(id)sender;
- (IBAction)didClickedSubmitButton:(id)sender;

@end

@implementation OrderRefundView

#pragma mark Initialization


- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self = [super awakeAfterUsingCoder:aDecoder];
    static BOOL bLoad;
    if (!bLoad)
    {
        bLoad = YES;
        OrderRefundView *view = [ToolBox getObjectFromNibWithView:self];
        [view buildSubviews];
        return view;
    }
    bLoad = NO;
    return self;
}

- (void)buildSubviews {
    
    self.stepperView.stepperDelegate = self;
    
    [self.refundAmountView setContentColor:COLOR_PINK];
    [self.refundAmountView setUnitFont:[UIFont systemFontOfSize:16]];
    [self.refundAmountView setPriceFont:[UIFont systemFontOfSize:20]];
    
    [self.backPointNumberLabel setTextColor:COLOR_PINK];
    
    self.reasonButton.layer.cornerRadius = 3;
    self.reasonButton.layer.masksToBounds = YES;
    self.reasonButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.reasonButton.layer.borderWidth = LINE_H;
    
    self.descriptionTextView.layer.cornerRadius = 3;
    self.descriptionTextView.layer.masksToBounds = YES;
    self.descriptionTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.descriptionTextView.layer.borderWidth = LINE_H;
    [self.descriptionTextView setPlaceHolderColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]];
    [self.descriptionTextView setPlaceHolderStr:@"请详细说明退款原因"];
    self.descriptionTextView.delegate = self;
    
    [self.submitButton setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
    [self.submitButton setBackgroundColor:COLOR_PINK forState:UIControlStateSelected];
    
    self.radishCountL.textColor = COLOR_PINK;
}

#pragma mark StepperViewDelegate

- (void)stepperView:(StepperView *)stepper valueChanged:(NSInteger)val byType:(eSteptype)type {
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderRefundView:didChangedRefundCountToValue:)]) {
        [self.delegate orderRefundView:self didChangedRefundCountToValue:val];
    }
}


#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.descriptionTextView.isPlaceHolderState)
    {
        [self.descriptionTextView setText:@""];
        [self.descriptionTextView setIsPlaceHolderState:NO];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text length] > 0) {
        [self.descriptionTextView setIsPlaceHolderState:NO];
    } else {
        [self.descriptionTextView setIsPlaceHolderState:YES];
    }
    [self.refundModel setRefundDescription:textView.text];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSInteger number = [text length];
    if (number > MAXREASONLENGTH) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字数不能大于200" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:MAXREASONLENGTH];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger number = [textView.text length];
    if (number > MAXREASONLENGTH) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字数不能大于200" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:MAXREASONLENGTH];
        number = MAXREASONLENGTH;
    }
    self.characterCountLabel.text = [NSString stringWithFormat:@"%ld/%d",(long)number, MAXREASONLENGTH];
}

#pragma mark Private methods

- (IBAction)didClickedReasonButton:(id)sender {
    [self endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedReasonButtonOnOrderRefundView:)]) {
        [self.delegate didClickedReasonButtonOnOrderRefundView:self];
    }
}

- (IBAction)didClickedSubmitButton:(id)sender {
    [self endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedSubmitButtonOnOrderRefundView:)]) {
        [self.delegate didClickedSubmitButtonOnOrderRefundView:self];
    }
}

#pragma mark Public methods

- (void)setMinCount:(NSInteger)min andMaxCount:(NSInteger)max {
    [self.stepperView setMaxVal:max andMinVal:min];
    if (max <= 1) {
        [self.countBGView setHidden:YES];
        self.countBGHeight.constant = 0;
    } else {
        [self.countBGView setHidden:NO];
        self.countBGHeight.constant = 60;
    }
}

- (void)setRefundRadishNum:(NSUInteger)num {
    if (num<1) {
        self.tipTopMargin.constant = 10;
        self.radishTipL.hidden = YES;
        self.radishCountL.hidden = YES;
    }else{
        self.tipTopMargin.constant = 38;
        self.radishTipL.hidden = NO;
        self.radishCountL.hidden = NO;
        self.radishCountL.text = [NSString stringWithFormat:@"%zd根",num];
    }
}

- (void)reloadData {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(refundModelForOrderRefundView:)]) {
        self.refundModel = [self.dataSource refundModelForOrderRefundView:self];
    }
    if (self.refundModel) {
        [self.refundAmountView setPrice:[self.refundModel refundAmount]];
        [self.backPointNumberLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)[self.refundModel backPoint]]];
        if (self.refundModel.selectedReasonItem) {
            [self.reasonButton setTitle:self.refundModel.selectedReasonItem.reasonName forState:UIControlStateNormal];
        } else {
            [self.reasonButton setTitle:@"退款原因" forState:UIControlStateNormal];
        }
        if ([self.refundModel.refundDescription length] > 0) {
            [self.descriptionTextView setIsPlaceHolderState:NO];
            [self.descriptionTextView setText:self.refundModel.refundDescription];
        } else {
            [self.descriptionTextView setText:@""];
            [self.descriptionTextView setIsPlaceHolderState:YES];
        }
    }
}

@end
