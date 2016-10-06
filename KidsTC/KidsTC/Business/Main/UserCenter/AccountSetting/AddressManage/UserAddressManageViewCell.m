//
//  UserAddressManageViewCell.m
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UserAddressManageViewCell.h"

@interface UserAddressManageViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *defaultTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deletBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineConstraintWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editBtnConstraintTrailingMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defaultTipLabelConstraintWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelDefaultLabelConstranitMargin;

@end

@implementation UserAddressManageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.defaultTipLabel.backgroundColor = COLOR_PINK;
    self.VLineConstraintWidth.constant = LINE_H;
    self.editBtn.tag = UserAddressManageViewCellActionTypeEdit;
    self.deletBtn.tag = UserAddressManageViewCellActionTypeDelet;
}

- (void)setFromeType:(UserAddressManageFromType)fromeType{
    _fromeType = fromeType;
    switch (fromeType) {
        case UserAddressManageFromTypeSettlement:
        {
            self.deletBtn.hidden = YES;
            self.editBtnConstraintTrailingMargin.constant = 16;
        }
            break;
        default:break;
    }
}

- (void)setItem:(UserAddressManageDataItem *)item{
    _item = item;
    self.defaultTipLabelConstraintWidth.constant = (item.isDefault==1)?30:0;
    self.nameLabelDefaultLabelConstranitMargin.constant = (item.isDefault==1)?8:0;
    self.nameLabel.textColor = (item.isDefault==1)?COLOR_PINK:[UIColor darkGrayColor];
    self.phoneLabel.textColor = self.nameLabel.textColor;
    self.nameLabel.text = item.peopleName;
    self.phoneLabel.text = item.mobile;
    self.addressLabel.text = item.addressDescription;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userAddressManageViewCell:actionType:)]) {
        [self.delegate userAddressManageViewCell:self actionType:(UserAddressManageViewCellActionType)sender.tag];
    }
}


@end
