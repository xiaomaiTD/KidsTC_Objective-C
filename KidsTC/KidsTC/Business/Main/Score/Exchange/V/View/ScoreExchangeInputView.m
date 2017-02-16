//
//  ScoreExchangeInputView.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreExchangeInputView.h"
#import "iToast.h"

@interface ScoreExchangeInputView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *totalRadishCountL;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UIView *inputBGView;

@property (weak, nonatomic) IBOutlet UILabel *radishCountL;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tfW;

@end

@implementation ScoreExchangeInputView

- (void)awakeFromNib {
    [super awakeFromNib];
    [NotificationCenter addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)setUserInfoData:(ScoreUserInfoData *)userInfoData {
    _userInfoData = userInfoData;
    self.totalRadishCountL.text = [NSString stringWithFormat:@"%@根",@(userInfoData.userRadishNum)];
    self.tf.text = [NSString stringWithFormat:@"%@",@(userInfoData.canMaxScore)];
    self.radishCountL.text = [NSString stringWithFormat:@"%@",@(userInfoData.canMaxScore*userInfoData.radishExchangeRate)];
    [self resetSubView];
}

- (void)startInput:(BOOL)start {
    if (start) {
        [self.tf becomeFirstResponder];
    }else{
        [self.tf resignFirstResponder];
    }
}

- (IBAction)exchangeAction:(UIButton *)sender {
    NSString *text = self.tf.text;
    if (![text respondsToSelector:@selector(integerValue)]) return;
    NSInteger score = text.integerValue;
    NSInteger radishNum = score*self.userInfoData.radishExchangeRate;
    if (score<=0) {
        [[iToast makeText:@"兑换积分不能为0"] show];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(scoreExchangeInputView:exchangeRadishNum:scoreNum:)]) {
        [self.delegate scoreExchangeInputView:self exchangeRadishNum:radishNum scoreNum:score];
    }
}

- (void)textFieldTextDidChange:(NSNotification *)obj {
    
    if (obj.object != self.tf) return;
    NSString *text = self.tf.text;
    if (![text respondsToSelector:@selector(integerValue)]) {
        text = [NSString stringWithFormat:@"%@",@(0)];
    };
    NSInteger score = text.integerValue;
    if (score>self.userInfoData.canMaxScore) {
        score = self.userInfoData.canMaxScore;
        NSString *tip = [NSString stringWithFormat:@"您拥有的萝卜最多只能兑换%@积分",@(score)];
        [[iToast makeText:tip] show];
    }
    if (score<=0) {
        score = 0;
    }
    text = [NSString stringWithFormat:@"%@",@(score)];
    self.radishCountL.text = [NSString stringWithFormat:@"%@",@(score*self.userInfoData.radishExchangeRate)];
    
    self.tf.text = text;
    
    [self resetSubView];
}

- (void)resetSubView {
    CGFloat tfw = [self.tf.text sizeWithAttributes:@{NSFontAttributeName:self.tf.font}].width + 16;
    if (tfw<34) tfw=34;
    self.tfW.constant = tfw;
    [self layoutIfNeeded];
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
