//
//  RecommendTarentoCollectTarentoHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendTarentoCollectTarentoHeader.h"

@interface RecommendTarentoCollectTarentoHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *signL;
@property (weak, nonatomic) IBOutlet UILabel *articleNumL;
@property (weak, nonatomic) IBOutlet UILabel *seeNumL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIView *toCollectBgView;
@end

@implementation RecommendTarentoCollectTarentoHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.cornerRadius = CGRectGetWidth(self.icon.bounds) * 0.5;
    self.icon.layer.masksToBounds = YES;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"333333"];
    self.signL.textColor = [UIColor colorFromHexString:@"888888"];
    self.articleNumL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
    self.seeNumL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
    
    self.collectBtn.layer.borderColor = [UIColor colorFromHexString:@"FF8888"].CGColor;
    self.collectBtn.layer.borderWidth = 1;
    self.collectBtn.layer.cornerRadius = 4;
    self.collectBtn.layer.masksToBounds = YES;
}

- (IBAction)action:(UIButton *)sender {
    
}

- (IBAction)collect:(UIButton *)sender {
}

@end
