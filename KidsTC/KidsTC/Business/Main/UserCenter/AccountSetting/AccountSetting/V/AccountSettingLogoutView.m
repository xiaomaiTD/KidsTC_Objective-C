//
//  AccountSettingLogoutView.m
//  KidsTC
//
//  Created by zhanping on 7/27/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AccountSettingLogoutView.h"

@interface AccountSettingLogoutView ()
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@end

@implementation AccountSettingLogoutView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.logoutBtn.backgroundColor = COLOR_PINK;
}
- (IBAction)action:(UIButton *)sender {
    if (self.logoutBlock) self.logoutBlock();
}


@end
