//
//  SettlementResultNewCollectionHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SettlementResultNewCollectionHeader.h"

@interface SettlementResultNewCollectionHeader ()
@property (weak, nonatomic) IBOutlet UIButton *goHomeBtn;
@property (weak, nonatomic) IBOutlet UIButton *showDetailBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;

@end

@implementation SettlementResultNewCollectionHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addCorner:self.goHomeBtn.layer];
    [self addCorner:self.showDetailBtn.layer];
}

- (void)addCorner:(CALayer *)layer {
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    layer.borderWidth = 1;
}

- (IBAction)goHome:(id)sender {
}
- (IBAction)showDetail:(id)sender {
    
}

@end
