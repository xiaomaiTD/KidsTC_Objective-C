//
//  UserAddressEditViewCell.m
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UserAddressEditViewCell.h"
#import "User.h"

@interface UserAddressEditViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *personBBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameTopLineConstraintHeight;
@property (weak, nonatomic) IBOutlet UILabel *nameTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameBottomLineConstraintHeight;

@property (weak, nonatomic) IBOutlet UIView *phoneBGView;
@property (weak, nonatomic) IBOutlet UILabel *phoneTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneLineConstraintHeight;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIView *areaBGView;
@property (weak, nonatomic) IBOutlet UILabel *areaTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaLineConstraintHeight;

@property (weak, nonatomic) IBOutlet UIView *addressBGView;
@property (weak, nonatomic) IBOutlet UILabel *addressTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTf;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressConstraintHeight;

@property (weak, nonatomic) IBOutlet UIView *defaultAddressBGView;
@property (weak, nonatomic) IBOutlet UILabel *defaultAddressTipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defaultAddressConstraintHeight;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (weak, nonatomic) IBOutlet UISwitch *defaultAddressSwitch;

@end

@implementation UserAddressEditViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameTopLineConstraintHeight.constant = LINE_H;
    self.nameBottomLineConstraintHeight.constant = LINE_H;
    self.phoneLineConstraintHeight.constant = LINE_H;
    self.areaLineConstraintHeight.constant = LINE_H;
    self.addressConstraintHeight.constant = LINE_H;
    self.defaultAddressConstraintHeight.constant = LINE_H;
    
    self.selectBtn.layer.borderWidth = LINE_H;
    self.selectBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.saveBtn.backgroundColor = COLOR_PINK;
    self.defaultAddressSwitch.onTintColor = COLOR_PINK;
    
    self.selectBtn.tag = UserAddressEditViewCellActionTypeSelect;
    self.saveBtn.tag = UserAddressEditViewCellActionTypeSave;
    
    NSString *defaultAddressTip = @"置为默认地址\n";
    NSString *defaultAddressSubTip = @"注：每次下单时会使用该地址";
    NSDictionary *att1 = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                           NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    NSDictionary *att2 = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                           NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    NSMutableAttributedString *defaultAddressAttTip = [[NSMutableAttributedString alloc]initWithString:defaultAddressTip attributes:att1];
    NSAttributedString *defaultAddressSubAttTip = [[NSAttributedString alloc]initWithString:defaultAddressSubTip attributes:att2];
    [defaultAddressAttTip appendAttributedString:defaultAddressSubAttTip];
    self.defaultAddressTipLabel.attributedText = defaultAddressAttTip;
    
    UITapGestureRecognizer *areaTapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(areaTapAction:)];
    [self.areaBGView addGestureRecognizer:areaTapGR];
}

- (void)setModel:(UserAddressEditModel *)model{
    _model = model;
    self.nameTf.text = model.name;
    self.phoneTf.text = model.phone;
    self.areaLabel.text = self.areaStr;
    self.addressTf.text = model.address;
    self.defaultAddressSwitch.on = model.isDefaultAddressRecorde;
}

- (NSString *)areaStr{
    __block NSMutableString *area = [NSMutableString string];
    [self.model.area enumerateObjectsUsingBlock:^(AddressDataItem *obj, NSUInteger idx, BOOL *stop) {
        [area appendFormat:@"%@ ",obj.address];
    }];
    return area;
}

- (IBAction)action:(UIButton *)sender {
    [self endEditing:YES];
    if ([self.delegate respondsToSelector:@selector(userAddressEditViewCell:actionType:)]) {
        [self.delegate userAddressEditViewCell:self actionType:(UserAddressEditViewCellActionType)sender.tag];
    }
}

- (void)areaTapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(userAddressEditViewCell:actionType:)]) {
        [self.delegate userAddressEditViewCell:self actionType:UserAddressEditViewCellActionTypeTapArea];
    }
}

- (IBAction)switchAction:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(userAddressEditViewCell:switchOn:)]) {
        [self.delegate userAddressEditViewCell:self switchOn:sender.isOn];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    UserAddressEditViewCellEditType editType = kNilOptions;
    if (textField==self.nameTf) {editType = UserAddressEditViewCellEditTypeName;}else
    if (textField==self.phoneTf){editType = UserAddressEditViewCellEditTypePhone;}else
    if (textField==self.addressTf){editType = UserAddressEditViewCellEditTypeAddress;}
    if ([self.delegate respondsToSelector:@selector(userAddressEditViewCell:endEditing:type:)]) {
        [self.delegate userAddressEditViewCell:self endEditing:textField.text type:editType];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
}

@end
