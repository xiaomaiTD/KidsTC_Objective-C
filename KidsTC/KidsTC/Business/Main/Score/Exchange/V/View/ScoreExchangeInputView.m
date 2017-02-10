//
//  ScoreExchangeInputView.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreExchangeInputView.h"

@interface ScoreExchangeInputView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *radishCountL;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UIView *inputBGView;
@property (weak, nonatomic) IBOutlet UIView *tfBGView;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tfW;
@property (weak, nonatomic) IBOutlet UILabel *scoreCountL;

@end

@implementation ScoreExchangeInputView

- (void)awakeFromNib {
    [super awakeFromNib];
    [NotificationCenter addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)startInput:(BOOL)start {
    if (start) {
        [self.tf becomeFirstResponder];
    }else{
        [self.tf resignFirstResponder];
    }
}

- (IBAction)exchangeAction:(UIButton *)sender {
    
}

- (void)textFieldTextDidChange:(NSNotification *)obj {
    
    if (obj.object != self.tf) return;
    TCLog(@"%@",obj);
    CGFloat tfw = [self.tf.text sizeWithAttributes:@{NSFontAttributeName:self.tf.font}].width;
    if (tfw<34) tfw=34;
    self.tfW.constant = tfw;
    [self.tfBGView setNeedsLayout];
    [self.tfBGView layoutIfNeeded];
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
