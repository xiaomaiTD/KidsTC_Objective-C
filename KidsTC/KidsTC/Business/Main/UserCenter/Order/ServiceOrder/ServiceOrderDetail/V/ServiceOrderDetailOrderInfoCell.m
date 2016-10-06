//
//  ServiceOrderDetailOrderInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailOrderInfoCell.h"
#import "NSString+Category.h"

@interface ServiceOrderDetailOrderInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderInfoLabel;
@property (weak, nonatomic) IBOutlet UIView *contactView;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contactBtnConstraintHeight;
@end

@implementation ServiceOrderDetailOrderInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.orderStateLabel.textColor = COLOR_PINK;
    
    self.contactLabel.textColor = COLOR_BLUE;
    
    CALayer *layer = self.contactView.layer;
    layer.borderColor = COLOR_BLUE.CGColor;
    layer.borderWidth = 1;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contactView addGestureRecognizer:tapGR];
}


- (void)setData:(ServiceOrderDetailData *)data{
    [super setData:data];
    
    self.contactView.hidden = !(data.supplierPhones.count>0);
    self.contactBtnConstraintHeight.constant = self.contactView.hidden?0:40;
    
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单编号：%@",data.oderId];
    NSString *state = data.orderStateName;
    self.orderStateLabel.text = [state isNotNull]?state:@"";
    self.orderInfoLabel.attributedText = data.orderInfoStr;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(serviceOrderDetailBaseCell:actionType:)]) {
        [self.delegate serviceOrderDetailBaseCell:self actionType:ServiceOrderDetailBaseCellActionTypeContact];
    }
}

@end
