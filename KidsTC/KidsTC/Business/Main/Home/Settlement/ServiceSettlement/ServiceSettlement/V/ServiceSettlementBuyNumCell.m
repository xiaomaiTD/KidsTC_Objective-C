//
//  ServiceSettlementBuyNumCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementBuyNumCell.h"
#import "ServiceSettlementBuyNumTfInputView.h"
#import "iToast.h"

@interface ServiceSettlementBuyNumCell ()<UITextFieldDelegate,ServiceSettlementBuyNumTfInputViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UILabel *buyLimitL;
@end

@implementation ServiceSettlementBuyNumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.container.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.container.layer.borderWidth = LINE_H;
    self.container.layer.cornerRadius = 4;
    self.container.layer.masksToBounds = YES;
    
    ServiceSettlementBuyNumTfInputView *inputView = [[NSBundle mainBundle] loadNibNamed:@"ServiceSettlementBuyNumTfInputView" owner:self options:nil].firstObject;
    inputView.delegate = self;
    inputView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    self.tf.inputAccessoryView = inputView;
    
    [NotificationCenter addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    [super setItem:item];
    
    self.tf.text = [NSString stringWithFormat:@"%zd",item.count];
    self.buyLimitL.text = [NSString stringWithFormat:@"限购%zd件",item.maxBuyNum];
    
    [self setupEnable];
}
- (IBAction)reduce:(UIButton *)sender {
    NSInteger count = self.tf.text.integerValue;
    self.tf.text = [NSString stringWithFormat:@"%zd",--count];
    [self resetText];
    [self setupEnable];
    [self checkTextFieldChange];
    [self layoutIfNeeded];
}
- (IBAction)add:(UIButton *)sender {
    NSInteger count = self.tf.text.integerValue;
    self.tf.text = [NSString stringWithFormat:@"%zd",++count];
    [self resetText];
    [self setupEnable];
    [self checkTextFieldChange];
    [self layoutIfNeeded];
}

- (void)setupEnable {
    NSInteger count = self.tf.text.integerValue;
    
    if (count<=self.item.minBuyNum) {
        self.reduceBtn.enabled = NO;
    }else{
        self.reduceBtn.enabled = YES;
    }
    if (count>=self.item.maxBuyNum) {
        self.addBtn.enabled = NO;
    }else{
        self.addBtn.enabled = YES;
    }
    if (self.reduceBtn.enabled==NO && self.addBtn.enabled == NO) {
        self.tf.enabled = NO;
    }
}

- (void)checkTextFieldChange{
    
    if (![[NSString stringWithFormat:@"%zd",self.item.count] isEqualToString:self.tf.text]) {
        if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
            [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeBuyNumDidChange value:self.tf.text];
        }
    }
}

- (void)resetText {
    
    if (self.item==nil) return;
    
    NSInteger count = self.tf.text.integerValue;
    if (count<self.item.minBuyNum) {
        iToast *toast = [iToast makeText:@"您所填写的数量低于该商品最小购买数量限制，小童已为您置为最小购买数量，请留意相应支付价格的变化哦~"];
        [toast setDuration:3000];
        [toast show];
        self.tf.text = [NSString stringWithFormat:@"%zd",self.item.minBuyNum];
    }
    if (count>self.item.maxBuyNum) {
        iToast *toast = [iToast makeText:@"您所填写的数量大于该商品最大购买数量限制，小童已为您置为最大购买数量，请留意相应支付价格的变化哦~"];
        [toast setDuration:3000];
        [toast show];
        self.tf.text = [NSString stringWithFormat:@"%zd",self.item.maxBuyNum];
    }
}

#pragma mark - addObserverMethod

- (void)textFieldTextDidChange {
    [self setupEnable];
    [self.container layoutIfNeeded];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self resetText];
    [self setupEnable];
    [self checkTextFieldChange];
    [self layoutIfNeeded];
}

#pragma mark - ServiceSettlementBuyNumTfInputViewDelegate

- (void)serviceSettlementBuyNumTfInputView:(ServiceSettlementBuyNumTfInputView *)view
                                actionType:(ServiceSettlementBuyNumTfInputViewActionType)type
                                     value:(id)value
{
    switch (type) {
        case ServiceSettlementBuyNumTfInputViewActionTypeCancel:
        {
            self.tf.text = [NSString stringWithFormat:@"%zd",self.item.count];
        }
            break;
        case ServiceSettlementBuyNumTfInputViewActionTypeSure:
        {
            
        }
            break;
    }
    [self.tf resignFirstResponder];
}

- (void)dealloc
{
    [NotificationCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
