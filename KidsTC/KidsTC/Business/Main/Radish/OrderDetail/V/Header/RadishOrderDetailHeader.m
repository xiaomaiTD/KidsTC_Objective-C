//
//  RadishOrderDetailHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailHeader.h"

@interface RadishOrderDetailHeader ()
@property (weak, nonatomic) IBOutlet UIButton *showRuleBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation RadishOrderDetailHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showRuleBtn.tag = RadishOrderDetailHeaderActionTypeShowRule;
    self.closeBtn.tag = RadishOrderDetailHeaderActionTypeClose;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishOrderDetailHeader:actionType:)]) {
        [self.delegate radishOrderDetailHeader:self actionType:(RadishOrderDetailHeaderActionType)sender.tag];
    }
}

@end
