//
//  FlashServiceOrderDetailRemindView.m
//  KidsTC
//
//  Created by zhanping on 2016/9/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "FlashServiceOrderDetailRemindView.h"

@interface FlashServiceOrderDetailRemindView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation FlashServiceOrderDetailRemindView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.deleteBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.titleLabel addGestureRecognizer:tapGR];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(flashServiceOrderDetailRemindView:actionType:)]) {
        [self.delegate flashServiceOrderDetailRemindView:self actionType:FlashServiceOrderDetailRemindViewActionTypeLink];
    }
}

- (IBAction)deleteAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(flashServiceOrderDetailRemindView:actionType:)]) {
        [self.delegate flashServiceOrderDetailRemindView:self actionType:FlashServiceOrderDetailRemindViewActionTypeDelete];
    }
}

@end
