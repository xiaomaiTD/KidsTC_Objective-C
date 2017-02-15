//
//  StoreDetailAppointmentContactCell.m
//  KidsTC
//
//  Created by zhanping on 8/21/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "StoreDetailAppointmentContactCell.h"
#import "User.h"
#import "iToast.h"
#import "NSString+Category.h"

@interface StoreDetailAppointmentContactCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation StoreDetailAppointmentContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.backgroundColor = COLOR_PINK;
    self.btn.layer.cornerRadius =8;
    self.btn.layer.masksToBounds = YES;
    self.tf.text = [[User shareUser].phone isNotNull]?[User shareUser].phone:@"";
}


- (IBAction)action:(UIButton *)sender {
    if (self.tf.text.length==0) {
        [[iToast makeText:@"请填写您的联系方式"]show];
    }else{
        if ([self.delegate respondsToSelector:@selector(storeDetailAppointmentBaseCell:actionType:value:)]) {
            [self.delegate storeDetailAppointmentBaseCell:self actionType:StoreDetailAppointmentBaseCellActionTypeMakeAppointment value:self.tf.text];
        }
    }
}

@end
